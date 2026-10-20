function Y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	YAZI_CONFIG_HOME=~/.config/yazi-hidden/ yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
