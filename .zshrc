# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/haarit/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/haarit/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/haarit/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/haarit/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



# Add this to ~/.bashrc or source it from a script
runcp() {
  local src="$1"
  local infile="$HOME/input_cp.txt"
  local outfile="$HOME/output_cp.txt"
  # derive binary name from source file (e.g. foo.cpp → foo)
  local bin="a.out"

  # compile
  g++ -std=c++17 -O2 "$src" -o "$bin"
  if [ $? -ne 0 ]; then
    echo "Compilation failed. Aborting."
    return 1
  fi

  # run with redirection
  ./"$bin" < "$infile" > "$outfile"
  local rc=$?

  if [ $rc -ne 0 ]; then
    echo "Program exited with code $rc."
  else
    echo "Success! Output written to $outfile."
  fi
	
  cat "$outfile"
  return $rc
}

gencpfile() {
  # grab the first argument
  fileName="$1"
  
  # guard against missing filename
  if [[ -z "$fileName" ]]; then
    echo "Usage: gencpfile <filename.cpp>"
    return 1
  fi

  if [[ -e "$fileName" ]]; then
    echo "Error: '$fileName' already exists. Aborting."
    return 1
  fi

  # write the boilerplate
  cat > "$fileName" <<'EOF'
#include <bits/stdc++.h>
using namespace std;

const int MOD = 1e9+71

using ll = long long;
using pii = pair<int,int>;
using pll = pair<ll,ll>;
using mll = unordered_map<ll,ll>;
using mii = unordered_map<int,int>;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int t = 1;
    // cin >> t;
    while (t--) {
        // write your code here

    }
    return 0;
}
EOF
  echo "Created $fileName"
  nvim "$fileName"
}



export PATH="$HOME/.volta/bin:$PATH"
export PATH="$HOME/.volta/bin:$PATH"

alias cls='clear'
