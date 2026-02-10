(use-modules (gnu home)
		(guix gexp)
		(gnu home services)
		(gnu home services gnupg)
		(gnu home services shells)
		(gnu home services ssh)
		(gnu home services sound)
		(gnu home services desktop)
		(gnu home services dotfiles)
		(gnu home services niri)
		(gnu home services pm)
		(gnu packages gnupg)
		(gnu packages))
(home-environment
		(packages
		(specifications->packages
		(list
		;; essentials
		"fastfetch-minimal"
		"openssl"
		"dbus"
		"openssh"
		"adb"
		"gnupg"
		"pinentry-emacs"
		"brightnessctl"
		"unzip"
		"glibc-locales"
		"curl"
		"git-minimal"
		"tree"
		"which"
		"grep"
		"direnv"
		"stow"
		"fontconfig"
		"groff"
		"xpdf"
		"font-google-noto-sans-cjk"
		"font-google-noto-emoji"
		"font-dejavu"
		"font-iosevka"
		;; noice apps
		"aria2"
		"yt-dlp"
		"mpv"
		"icecat-minimal"
		"libass"
		"ffmpeg"
		"imagemagick"
		"groff"
		"niri"
		"xwayland-satellite"
		"xdg-desktop-portal-gtk"
		"libnotify"
		"mako"
		"swaybg"
		"wf-recorder"
		"pipewire"
		"wireplumber"
		"ledger"
		"podman"
		"podman-compose"
		;; emacs
		"chess"
		"guile"
		"ispell"
		"emacs-next-pgtk"
		"emacs-guix"
		"emacs-geiser"
		"emacs-pdf-tools"
		"emacs-xwidgets"
		"emacs-pulsar"
		"emacs-emms"
		"emacs-org-drill"
		"emacs-org-modern"
		"emacs-ledger-mode"
		"emacs-cape"
		"emacs-eat"
		"emacs-pinentry"
		"emacs-gptel"
		"emacs-rustic"
		"emacs-envrc"
		"emacs-chess"
		"emacs-typit"
		"emacs-sudoku"
		"emacs-ement"
		"emacs-mastodon"
		)))
		;; add dotfiles
		(services
		(append
		(list
		(service home-pipewire-service-type)
		(service home-dbus-service-type)
		(service home-openssh-service-type)
		(service home-gpg-agent-service-type
		(home-gpg-agent-configuration
		(pinentry-program
		(file-append pinentry-emacs "/bin/pinentry-emacs"))
		(ssh-support? #t)))
		(service home-niri-service-type)
		(service home-bash-service-type
		(home-bash-configuration
		(aliases
		'(
		("ls" . "ls --almost-all")
		("u" . "guix home reconfigure ~/alchemy/dotfiles/guix/.config/guix/home.scm")
		))
		(environment-variables
		'(
		("PATH" . "$PATH:$HOME/.local/bin")
		("GUIX_PROFILE" . "$HOME/.guix-profile")
		("GUIX_EXTRA_PROFILES" . "$HOME/.guix-extra-profiles")
		("SSL_CERT_DIR" . "$HOME/.guix-profile/etc/ssl/certs")
		("SSL_CERT_FILE" . "$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt")
		("GIT_SSL_CAINFO" . "$SSL_CERT_FILE")
		("CURL_CA_BUNDLE" . "$SSL_CERT_FILE")
		("QT_QPA_PLATFORM" . "wayland")
		("QT_WAYLAND_DISABLE_WINDOWDECORATION" . "1")
		("LANG" . "en_US.UTF-8")
		("LC_ALL" . "en_US.UTF-8")
		("TERM" . "xterm-256color")
		("GPG_TTY" . "/dev/tty1")
		("BROWSER" . "icecat")
		))
		(bashrc (list (local-file "/home/sunless/alchemy/dotfiles/shell/.bashrc" "bashrc")))
		(bash-profile (list (local-file "/home/sunless/alchemy/dotfiles/shell/.bash-profile" "bash-profile")))
		)
		)
		(service home-dotfiles-service-type
		(home-dotfiles-configuration
		(directories '("/home/sunless/alchemy/dotfiles"))
		(layout 'stow)
		(packages
		'(
		"aria2"
		"emacs"
		"mpv"
		"guix"
		"niri"
		))
		)
		)
		)%base-home-services)))
