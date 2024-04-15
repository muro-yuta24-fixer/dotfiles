#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Check if fish shell is installed, if yes then use it
if type fish >/dev/null 2>&1; then
    exec fish
fi
