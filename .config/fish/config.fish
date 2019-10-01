# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

set -U fish_user_abbreviations
# set -U fish_user_abbreviations $fish_user_abbreviations 'c=cargo'
set -U fish_user_abbreviations $fish_user_abbreviations 'm=make'
set -U fish_user_abbreviations $fish_user_abbreviations 'o=xdg-open'
set -U fish_user_abbreviations $fish_user_abbreviations 'g=git'
set -U fish_user_abbreviations $fish_user_abbreviations 'gc=git checkout'
set -U fish_user_abbreviations $fish_user_abbreviations 'vimdiff=nvim -d'
set -U fish_user_abbreviations $fish_user_abbreviations 'gah=git stash; and git pull --rebase; and git stash pop'
set -U fish_user_abbreviations $fish_user_abbreviations 'nv=nvim'

if status --is-interactive
	tmux ^ /dev/null; and exec true
	# tmux attach; and exec true
end

if exa --version >/dev/null
	set -U fish_user_abbreviations $fish_user_abbreviations 'l=exa'
	set -U fish_user_abbreviations $fish_user_abbreviations 'ls=exa'
	set -U fish_user_abbreviations $fish_user_abbreviations 'll=exa -l'
	set -U fish_user_abbreviations $fish_user_abbreviations 'lll=exa -la'
else
	set -U fish_user_abbreviations $fish_user_abbreviations 'l=ls'
	set -U fish_user_abbreviations $fish_user_abbreviations 'll=ls -l'
	set -U fish_user_abbreviations $fish_user_abbreviations 'lll=ls -la'
end

if [ -e /usr/share/fish/functions/fzf_key_bindings.fish ]; and status --is-interactive
	source /usr/share/fish/functions/fzf_key_bindings.fish
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

function limit
	numactl -C 0,2 $argv
end

function remote_alacritty
	# https://gist.github.com/costis/5135502
	set fn (mktemp)
	infocmp alacritty-256color > $fn
	scp $fn $argv[1]":alacritty-256color.ti"
	ssh $argv[1] tic "alacritty-256color.ti"
	ssh $argv[1] rm "alacritty-256color.ti"
end

set nooverride PATH PWD
function onchdir -v PWD
	set dr $PWD
	while [ "$dr" != "/" ]
		for e in $dr/.setenv-*
			set envn (basename -- $e | sed 's/^\.setenv-//')
			if contains $envn $nooverride
				continue
			end

			if not test -s $e
				# setenv is empty
				# var value is file's dir
				set envv (readlink -e $dr)
			else if test -L $e; and test -d $e
				# setenv is symlink to directory
				# var value is target directory
				set envv (readlink -e $e)
			else
				# setenv is non-empty file
				# var value is file content
				set envv (cat $e)
			end

			if not contains $envn $wasset
				set wasset $wasset $envn
				setenv $envn $envv
			end
		end
		set dr (dirname $dr)
	end
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

set PATH $PATH ~/projects/ims/tests/tools/titan/ttcn3/bin
set PATH /usr/local/bin/ $PATH
set PATH $PATH ~/bin
set PATH $PATH ~/.local/bin
set PATH $PATH ~/.cargo/bin
set PATH $PATH ~/.npm-global/bin
set PATH $PATH ~/dev/go/bin
set PATH $PATH ~/.yarn/bin
set PATH $PATH ~/dev-tools/android/android-sdk-linux/tools
set PATH $PATH ~/dev-tools/android/android-sdk-linux/tools/bin/
set PATH $PATH ~/dev-tools/android/android-sdk-linux/build-tools
set PATH $PATH ~/dev-tools/android/ndk/android-ndk-r20/

# For RLS
# https://github.com/fish-shell/fish-shell/issues/2456
setenv LD_LIBRARY_PATH (rustc +stable --print sysroot)"/lib:$LD_LIBRARY_PATH"
setenv RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"

setenv EDITOR nvim
setenv BROWSER brave-browser
setenv EMAIL jon@tsp.io
setenv NAME "Jon Gjengset"
setenv GOPATH "$HOME/dev/go:$HOME/dev/projects/cuckood:$HOME/dev/projects/hasmail"
setenv RUST_BACKTRACE 1
setenv CARGO_INCREMENTAL 1
setenv RUSTFLAGS "-C target-cpu=native"
setenv WINEDEBUG fixme-all
setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'
setenv R_LIBS_USER ~/.Rpackages
setenv NVM_DIR ~/.nvm
alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"


# https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/
setenv TZ ":/etc/localtime"

set -U fish_user_abbreviations $fish_user_abbreviations 'nova=env OS_PASSWORD=(pass www/mit-openstack | head -n1) nova'
set -U fish_user_abbreviations $fish_user_abbreviations 'glance=env OS_PASSWORD=(pass www/mit-openstack | head -n1) glance'
setenv OS_USERNAME jfrg@csail.mit.edu
setenv OS_TENANT_NAME usersandbox_jfrg
setenv OS_AUTH_URL https://nimbus.csail.mit.edu:5001/v2.0
setenv OS_IMAGE_API_VERSION 1
setenv OS_VOLUME_API_VERSION 2
function penv -d "Set up environment for the PDOS openstack service"
	env OS_PASSWORD=(pass www/mit-openstack | head -n1) OS_TENANT_NAME=pdos OS_PROJECT_NAME=pdos $argv
end
function pvm -d "Run nova/glance commands against the PDOS openstack service"
	switch $argv[1]
	case 'image-*'
		penv glance $argv
	case 'c'
		penv cinder $argv[2..-1]
	case 'g'
		penv glance $argv[2..-1]
	case '*'
		penv nova $argv
	end
end

#setenv QT_DEVICE_PIXEL_RATIO 2
#setenv GDK_SCALE 2
#setenv GDK_DPI_SCALE 0.5
#setenv JAVA_HOME /home/ali/dev-tools/java/jdk-12/
setenv JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
setenv _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
setenv JAVA_FONTS /usr/share/fonts/TTF
setenv MATLAB_JAVA /usr/lib/jvm/default-runtime
setenv J2D_D3D false

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

set fish_color_command normal

# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/fish/base16-atelier-dune.sh
end

# Pretty ls colors
if test -e ~/.dir_colors
	setenv LS_COLORS (sh --noprofile -c 'eval "$(dircolors -b ~/.dir_colors)"; echo $LS_COLORS')
end

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	if functions -q fzf_key_bindings
		fzf_key_bindings
	end
end

function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo

	echo -e " \\e[1mNetwork:\\e[0m"
	echo
	# http://tdt.rocks/linux_network_interface_naming.html
	echo -ne (\
		ip addr show up scope global | \
			grep -E ': <|inet' | \
			sed \
				-e 's/^[[:digit:]]\+: //' \
				-e 's/: <.*//' \
				-e 's/.*inet[[:digit:]]* //' \
				-e 's/\/.*//'| \
			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
			sort | \
			column -t -c 1 | \
			# public addresses are underlined for visibility \
			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
			# private addresses are not \
			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
			# unknown interfaces are cyan \
			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
			# ethernet interfaces are normal \
			sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
			# wireless interfaces are purple \
			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
			# wwan interfaces are yellow \
			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
			sed 's/$/\\\e[0m/' | \
			sed 's/^/\t/' \
		)
	echo

	#set r (random 0 100)
	#if [ $r -lt 5 ] # only occasionally show backlog (5%)
	#	echo -e " \e[1mBacklog\e[0;32m"
	#	set_color blue
	#	echo "  [project] <description>"
	#	echo
	#end

	set_color normal
end
