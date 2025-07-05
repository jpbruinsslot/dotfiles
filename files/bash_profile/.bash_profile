# .bash_profile
#
# .bash_profile is executed for login shells, while .bashrc is executed for
# interactive non-login shells. By either logging in with your username and
# password locally or ssh, the .bash_profile file is executed to configure
# your shell before the initial command prompt. But, if you're already logged
# into your machine and open a new terminal window then the .bashrc file
# is executed before the window command prompt.
#
# Source: http://apple.stackexchange.com/a/51038

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,alias,functions,path,dockerfunc,extra,exports}; do
    [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2>/dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
    -o "nospace" \
    -W "$(grep "^Host" ~/.ssh/config |
        grep -v "[?*]" | cut -d " " -f2 |
        tr ' ' '\n')" scp sftp ssh

# Rust
[[ -f "/home/jp/.config/autopackage/paths-bash" ]] && . "/home/jp/.config/autopackage/paths-bash"
. "$HOME/.cargo/env"
