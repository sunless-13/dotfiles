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
     "sx"
     "xset"
     "xhost"
     "curl"
     "git"
     "sqlite"
     "tree"
     "which"
     "eza"
     "grep"
     "direnv"
     "bat"
     "stow"
     "fontconfig"
     "font-hack"
     "font-google-noto-emoji"
     ;; noice apps
     "aria2"
     "yt-dlp"
     "mpv"
     "icecat-minimal"
     ;; emacs
     "emacs"
     "emacs-exwm"
     ;; basic
     "emacs-evil"
     "emacs-evil-collection"
     "emacs-guix"
     "emacs-geiser"
     "emacs-geiser-guile"
     "emacs-helpful"
     "emacs-emms"
     "emacs-pdf-tools"
     "emacs-org-pdftools"
     "emacs-saveplace-pdf-view"
     "emacs-app-launcher"
     ;; icons and colors
     "emacs-org-modern"
     "emacs-org-superstar"
     "emacs-emojify"
     "emacs-rainbow-mode"
     ;; "emacs-all-the-icons"
     ;; "emacs-all-the-icons-dired"
     ;; dev
     "emacs-envrc"
     "emacs-markdown-mode"
     "emacs-gptel"
     "emacs-eat"
     ;; "emacs-vertico"
     ;; "emacs-vertico-posframe"
     ;; "emacs-avy"
     ;; "emacs-consult"
     ;; "emacs-orderless"
     ;; "emacs-corfu"
     "emacs-cape"
     "emacs-marginalia"
     "emacs-pulsar"
     "ispell"
     ;; misc
     "emacs-yeetube"
     "emacs-org-drill"
     "emacs-chess"
     "chess" ;; gnuchess (default is phalanx)
     "stockfish"
     "emacs-sudoku"
     ;; react dev
     "gcc-toolchain"
     "bash-minimal"
     "coreutils"
     "sed"
     "tar"
     "gzip"
     "findutils"
     "gawk"
     "vscodium"
     ;; rust dev
     "xz"
     "libgccjit"
     "at-spi2-core"
     "atkmm"
     "cairo"
     "gdk-pixbuf"
     "glib"
     "gtk"
     "harfbuzz"
     "librsvg"
     "libsoup"
     "pango"
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
               ))
          )
      )
      )%base-home-services)))
