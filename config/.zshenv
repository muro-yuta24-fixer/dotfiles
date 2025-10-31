# History
export HISTSIZE=1048576
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"

# Nodenv
export NODE_MAKE_OPTS="-j16 -l18"
export NODE_CFLAGS="-march=native -O2 -flto -pipe"

# PATH
export PATH="$HOME/.local/npm/bin:$HOME/.local/bin:$PATH"
