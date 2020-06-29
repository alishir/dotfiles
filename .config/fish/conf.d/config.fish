alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

set MANPATH /usr/share/man
set PATH /home/ali/bin $PATH
set PATH /home/ali/.kiex/bin/ $PATH
set PATH /home/ali/dev-tools/node/current/bin $PATH
set PATH /home/ali/dev-tools/go/bin $PATH
set PATH /home/ali/.cargo/bin $PATH
set PATH /home/ali/.cache/rebar3/bin $PATH

source /home/ali/.kerl/22.3/activate.fish
source /home/ali/.kiex/elixirs/elixir-1.10.2.env   
alias rb="rebar3"
alias gb="go build"


starship init fish | source
