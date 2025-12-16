(use-modules (gnu home)
						 (guix gexp)
						 (gnu home services)
						 (gnu home services shells)
						 (gnu home services ssh)
						 (gnu home services sound)
						 (gnu home services desktop)
						 (gnu home services dotfiles)
						 (gnu packages))

(home-environment
	(packages
	 (specifications->packages
		(list
		 ;; essentials
		 "dbus"
		 "brightnessctl"
		 "unzip"
		 "glibc-locales"
		 "curl"
		 "git-minimal"
		 "groff"
		 "tree"
		 "which"
		 "eza"
		 "grep"
		 ;; "direnv"
		 "bat"
		 "stow"
		 "fontconfig"
		 "groff"
		 "ghostscript"
		 "imagemagick"
		 "xpdf"
		 "font-google-noto-sans-cjk"
		 "font-google-noto-emoji"
		 "font-dejavu"
		 "font-microsoft-times-new-roman"
		 "openssh"
		 ;; noice apps
		 "aria2"
		 "yt-dlp"
		 "mpv"
		 "icecat-minimal"
		 "ungoogled-chromium-wayland"
		 "niri"
		 "xwayland-satellite"
		 "xdg-desktop-portal-gtk"
		 "mako"
		 "wf-recorder"
		 "pipewire"
		 "wireplumber"
		 "ledger"
		 ;; "vscodium"
		 ;; "gimp"
		 ;; emacs
		 "chess"
		 "guile"
		 "emacs-pgtk"
		 "emacs-guix"
		 "emacs-geiser"
		 "emacs-geiser-guile"
		 "emacs-pdf-tools"
		 )))
	;; add dotfiles
	(services
	 (append
		(list
		 (service home-pipewire-service-type)
		 (service home-dbus-service-type)
		 (service home-openssh-service-type)
		 (service home-bash-service-type
				(home-bash-configuration
					(aliases
					 '(
							("ls" . "eza --almost-all --git-ignore")
							("u" . "guix home reconfigure ~/alchemy/dotfiles/guix/.config/guix/home.scm")
							))
					(environment-variables
					 '(
							("PATH" . "$PATH:$HOME/.local/bin")
							("GUIX_PROFILE" . "$HOME/.guix-profile")
							("SSL_CERT_DIR" . "$HOME/.guix-profile/etc/ssl/certs")
							("SSL_CERT_FILE" . "$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt")
							("GIT_SSL_CAINFO" . "$SSL_CERT_FILE")
							("CURL_CA_BUNDLE" . "$SSL_CERT_FILE")
							("QT_QPA_PLATFORM" . "wayland")
							("QT_WAYLAND_DISABLE_WINDOWDECORATION" . "1")
							("LANG" . "en_US.UTF-8")
							("LC_ALL" . "en_US.UTF-8")
							("TERM" . "xterm-256color")
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
