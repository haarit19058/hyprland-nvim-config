# This is the  first time i am trying neovim and hyperland 
- There is a channel named typecraft the i am learning from and he is teaching how to setup the proper development environment using neovima nd how to setup hyprland and how it works in grim details. For now i will use nvim and hyprland and not exploring further .
It is better to get a good grip of the workflow before doing more and hence i stop at colorscheme and telescope in neovim.




For competitive Programming we do the following
- Define this function in .bashrc and use it

function runcp() {
  local src=${1:-main.cpp}
  local exe=a.out
  local inp="$HOME/input_cp.txt"
  local out="$HOME/output_cp.txt"
  g++ -std=c++17 -O2 "$src" -o "$exe" && ./"$exe" < "$inp" > "$out"
}

