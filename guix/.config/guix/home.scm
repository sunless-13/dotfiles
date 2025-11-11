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
		 "nss-certs"
		 "openssh"
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
		 "direnv"
		 "bat"
		 "stow"
		 "fontconfig"
		 "groff"
		 ;; noice apps
		 "aria2"
		 "yt-dlp"
		 "mpv"
		 "icecat-minimal"
		 "ungoogled-chromium-wayland"
		 "niri"
		 "xwayland-satellite"
		 "swayidle"
		 "swaybg"
		 ;; "xdg-desktop-portal-gtk"
		 "mako"
		 "gammastep"
		 "wf-recorder"
		 "gimp"
		 "pipewire"
		 "wireplumber"
		 ;; emacs
		 "ispell"
		 "chess"
		 "guile"
		 "emacs-pgtk"
		 "emacs-org-modern"
		 "emacs-pulsar"
		 "emacs-rainbow-mode"
		 "emacs-emojify"
		 "emacs-ement"
		 "emacs-guix"
		 "emacs-geiser"
		 "emacs-geiser-guile"
		 "emacs-app-launcher"
		 "emacs-pdf-tools"
		 "emacs-saveplace-pdf-view"
		 "emacs-emms"
		 "emacs-helpful"
		 "emacs-chess"
		 "emacs-cape"
		 "emacs-marginalia"
		 "emacs-magit"
		 "emacs-docker"
		 "emacs-gptel"
		 ;; "emacs-envrc"

		 ;; rust
		 "coreutils"
		 "gcc-toolchain"
		 "libgccjit"
		 ;; "at-spi2-core"
		 "atkmm"
		 ;; "cairo"
		 "gdk-pixbuf"
		 ;; "glib"
		 "gtk"
		 "harfbuzz"
		 "librsvg"
		 "libsoup"
		 ;; "pango"
		 "openssl"
		 "webkitgtk"
		 ;; macroquad
		 "pkg-config"
		 "libx11"
		 "libxi"
		 "libxcursor"
		 "libxrandr"
		 "mesa-opencl"
		 "alsa-lib"
		 ;; essentials
		 "bash-minimal"
		 "nss-certs"
		 "grep"
		 "curl"
		 "git"
		 "which"
		 "tar"
		 "gzip"
		 "xz"
		 ;; misc
		 "vscodium"

		 ;; react
		 "bash-minimal"
		 "coreutils"
		 "sed"
		 "tar"
		 "gzip"
		 "findutils"
		 "gawk"
		 "grep"
		 "git"
		 "nss-certs"
		 "curl"
		 "which"
		 "gcc-toolchain"
		 "vscodium"
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
							("XCURSOR_PATH" . "$HOME/.local/share/icons/")
							("XCURSOR_THEME" . "Adwaita")
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
							 ;; "sway"
							 ))
					)
			)
			)%base-home-services)))
