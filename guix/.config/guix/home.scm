(use-modules (gnu home)
             (guix gexp)
             (gnu home services)
             (gnu home services gnupg)
             (gnu home services shells)
             ;; (gnu home services ssh)
             ;; (gnu home services niri)
             (gnu home services sound)
             (gnu home services desktop)
             (gnu home services dotfiles)
             (gnu home services pm)
             (gnu packages gnupg)
             (gnu packages))
(home-environment
 (packages
  (specifications->packages
   (list
    ;; essentials
    "openssl"
    "dbus"
    "brightnessctl"
    "unzip"
    "glibc-locales"
    "curl"
    "git"
    "tree"
    "which"
    "grep"
    "stow"
    "fontconfig"
    ;; fonts
    "font-google-noto-sans-cjk"
    "font-google-noto-emoji"
    "font-iosevka"
    ;; sound
    "pipewire"
    "wireplumber"
    ;; android
    "adb"
    "openssh"
    ;; gpg
    "gnupg"
    "pinentry-emacs"
    ;; guix container
    "direnv"
    ;; pdf maker
    "groff"
    "xpdf"
    ;; editor
    "imagemagick"
    "wf-recorder"
    "ffmpeg"
    "libass"
    ;; window manager
    "niri"
    "xwayland-satellite"
    "xdg-desktop-portal-gtk"
    "libnotify"
    "mako"
    "swaybg"
    ;; containers
    "podman"
    "podman-compose"
    ;; noice apps
    "fastfetch-minimal"
    "aria2"
    "yt-dlp"
    "mpv"
    "librewolf"
    "icecat-minimal"
    ;; guix
    "guile"
    ;; dictionary
    "aspell"
    ;; doc-view dependencies
    "mupdf" 
    "libreoffice"
    ;; apps
    "chess"    
    "ledger"
    ;; emacs
    "emacs-next-pgtk"
    "emacs-guix"
    "emacs-geiser"
    "emacs-pulsar"
    "emacs-emms"
    "emacs-org-drill"
    "emacs-org-modern"
    "emacs-ledger-mode"
    "emacs-eat"
    "emacs-pinentry"
    "emacs-gptel"
    "emacs-rustic"
    "emacs-envrc"
    "emacs-chess"
    "emacs-typit"
    "emacs-sudoku"
    ;; "emacs-ement"
    ;; "emacs-mastodon"
    )))
 
 ;; service
 (services
  (append
   (list
    (service home-pipewire-service-type)
    ;; (service home-niri-service-type)
    (service home-dbus-service-type)
    (service home-gpg-agent-service-type
             (home-gpg-agent-configuration
              (pinentry-program
               (file-append pinentry-emacs "/bin/pinentry-emacs"))
              (ssh-support? #t)))
    (service home-bash-service-type
             (home-bash-configuration
              (aliases
               '(("ls" . "ls --almost-all")
                 ("u" . "guix home reconfigure ~/alchemy/dotfiles/guix/.config/guix/home.scm")
                 ))
              (environment-variables
               '(("PATH" . "$PATH:$HOME/.local/bin")
                 ("GUIX_PROFILE" . "$HOME/.guix-profile")
                 ("GUIX_EXTRA_PROFILES" . "$HOME/.guix-extra-profiles")
                 ("SSL_CERT_DIR" . "$GUIX_PROFILE/etc/ssl/certs")
                 ("SSL_CERT_FILE" . "$GUIX_PROFILE/etc/ssl/certs/ca-certificates.crt")
                 ("GIT_SSL_CAINFO" . "$SSL_CERT_FILE")
                 ("CURL_CA_BUNDLE" . "$SSL_CERT_FILE")
                 ("GUIX_LOCPATH" . "$GUIX_PROFILE/lib/locale")    
                 ("QT_QPA_PLATFORM" . "wayland")
                 ("QT_WAYLAND_DISABLE_WINDOWDECORATION" . "1")
                 ("LANG" . "en_US.UTF-8")
                 ("LC_ALL" . "en_US.UTF-8")
                 ("TERM" . "xterm-256color")
                 ("GPG_TTY" . "/dev/tty1")
                 ("BROWSER" . "icecat")
                 ))
              (bashrc
               (list
                (local-file "/home/sunless/alchemy/dotfiles/shell/.bashrc" "bashrc")))
              (bash-profile
               (list
                (local-file "/home/sunless/alchemy/dotfiles/shell/.bash-profile" "bash-profile")))
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
    ;; (service home-openssh-service-type)
    )%base-home-services)))
