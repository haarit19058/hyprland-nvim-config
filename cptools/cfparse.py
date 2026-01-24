import sys
import os
import re
import subprocess
from pathlib import Path
import time 
from datetime import datetime 

name = 'd0lph1n'
now = datetime.now()
date = now.date()
curr_time =  now.time()
author_str = f"/*\nAuthor : {name} \nDate : {date} \nTime : {curr_time}\n*/"

template = '''

// 10========== code_segment ==========10

#include <bits/stdc++.h>
using namespace std;

const int MOD = 1e9+7;

using ll = long long;
using pii = pair<int,int>;
using pll = pair<ll,ll>;
using mll = unordered_map<ll,ll>;
using mii = unordered_map<int,int>;

void solve(){
    // code goes here 
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int t = 1;
    cin >> t;
    while (t--) {
        solve();
    }
    return 0;
}

// 10========== test_cases ==========10

/*input

*/

/*output

*/

'''

template = author_str + template

def parse_file(filename):
    """
    Separates C++ source code from the test cases defined in comments.
    """
    
    

    with open(filename, 'r') as f:
        content = f.read()

    # 1. Split Code and Test Section
    # We look for the marker you provided.
    split_marker = "// 10========== test_cases ==========10"
    
    if split_marker in content:
        parts = content.split(split_marker)
        code_segment = parts[0].strip()
        test_segment = parts[1].strip()
    else:
        print(f"Warning: Marker '{split_marker}' not found. Assuming whole file is code.")
        return content, []

    # 2. Extract Inputs and Outputs using Regex
    # Looks for content between /*input */ and /*output */
    # re.DOTALL allows the dot (.) to match newlines
    input_pattern = r'/\*input\s*(.*?)\s*\*/'
    output_pattern = r'/\*output\s*(.*?)\s*\*/'

    inputs = re.findall(input_pattern, test_segment, re.DOTALL)
    outputs = re.findall(output_pattern, test_segment, re.DOTALL)

    test_cases = []
    # Zip combines the lists; assumes strict ordering (Input 1 -> Output 1)
    for inp, out in zip(inputs, outputs):
        test_cases.append({
            "input": inp.strip(),
            "expected": out.strip()
        })

    return code_segment, test_cases

def compile_code(source_code):
    """
    Writes the source to a temp file and compiles it using g++.
    """
    source_filename = "temp_solution.cpp"
    exe_filename = "solution_exec"

    # Write temp .cpp file
    with open(source_filename, 'w') as f:
        f.write(source_code)

    # Compile command (using g++)
    # -O2 optimizes code, similar to CP environments
    cmd = ["g++", "-O2", source_filename, "-o", exe_filename]

    print("🔨 Compiling...")
    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print("❌ Compilation Error:")
        print(result.stderr)
        return None
    
    print("✅ Compilation Successful.\n")
    return exe_filename

def run_tests(executable, test_cases):
    """
    Runs the executable against extracted test cases.
    """
    # Handle Windows vs Linux/Mac execution path
    run_cmd = f"./{executable}" if os.name != 'nt' else f"{executable}.exe"

    for i, test in enumerate(test_cases):
        input_data = test['input']
        expected_output = test['expected']

        print(f"--- 🧪 Test Case {i + 1} ---")
        print(f"Input:\n{input_data}")
        
        try:
            # Run the process
            # input=input_data passes string to stdin
            process = subprocess.run(
                [run_cmd],
                input=input_data,
                capture_output=True,
                text=True,
                timeout=2 # 2-second timeout to catch infinite loops
            )
            
            actual_output = process.stdout.strip()

            print(f"\nExpected:\n{expected_output}")
            print(f"\nYour Output:\n{actual_output}")

            if process.stderr:
                print(f"Stderr (Debug):\n{process.stderr}")

            # Comparison
            if actual_output == expected_output:
                print("\nResult: ✅ PASSED")
            else:
                print("\nResult: ❌ FAILED")

        except subprocess.TimeoutExpired:
            print("\nResult: ⏳ TIME LIMIT EXCEEDED (2s)")
        except Exception as e:
            print(f"\nResult: 💥 ERROR ({e})")
        
        print("\n" + "="*30 + "\n")

    # Cleanup temp files
    if os.path.exists("temp_solution.cpp"): os.remove("temp_solution.cpp")
    if os.path.exists(run_cmd): os.remove(run_cmd)
    if os.path.exists(executable): os.remove(executable)


def main():
    if len(sys.argv) < 2:
        print("Usage: python test_runner.py <filename.cpp>")
        sys.exit(1)

    filename = sys.argv[1]

    path = Path(filename)
    if not path.exists():
        path.write_text(template)
        os.execvp("nvim",["nvim",filename])
        sys.exit(1)

    # 1. Parse
    code, tests = parse_file(filename)

    if not tests:
        print("No test cases found. Exiting.")
        sys.exit(0)

    # 2. Compile
    executable = compile_code(code)

    if executable:
        # 3. & 4. Run and Compare
        run_tests(executable, tests)

if __name__ == "__main__":
    main()




