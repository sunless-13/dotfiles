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
     "fontconfig"
     "font-jetbrains-mono"
     "font-google-noto-emoji"
     ;; noice apps
     "eza"
     "direnv"
     "bat"
     "aria2"
     "stow"
     "yt-dlp"
     "icecat-minimal"
     "qutebrowser"
     "mpv"
     ;; emacs
     "emacs"
     "emacs-exwm"
     ;; essential
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
     "emacs-all-the-icons"
     "emacs-all-the-icons-dired"
     ;; dev
     "emacs-markdown-mode"
     "emacs-gptel"
     "emacs-eat"
     "emacs-magit"
     "emacs-vertico"
     "emacs-vertico-posframe"
     "emacs-consult"
     "emacs-orderless"
     "emacs-corfu"
     "emacs-cape"
     "emacs-marginalia"
     "emacs-avy"
     "emacs-pulsar"
     ;; misc
     "emacs-yeetube"
     "emacs-org-drill"
     "emacs-chess"
     "chess" ;; gnuchess (default is phalanx)
     "stockfish"
     "emacs-sudoku"
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
