(use-modules (gnu))
(use-service-modules admin desktop xorg networking docker)

;; main config
(operating-system
  ;; personal
  (host-name "sunless")
  (timezone "Africa/Nairobi")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "us"))

  ;; grub
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (timeout "0")))
  ;; file system
  (file-systems
   (append
    (list
     (file-system
        (device "/dev/sda1")
        (mount-point "/boot/efi")
        (type "vfat"))
     (file-system
        (device "/dev/sda2")
        (mount-point "/")
        (type "ext4"))
     (file-system
        (device "/dev/sda3")
        (mount-point "/home")
        (type "ext4"))) %base-file-systems))
  ;; users
  (users (cons (user-account
                 (name "sunless")
                 (group "users")
                 (supplementary-groups '("wheel" "audio" "video" "netdev"
                                         "input" "docker"))) %base-user-accounts))

  ;; packages.
  (packages %base-packages)

  ;; services
  (services
   (append (list (service sane-service-type)
                 (service elogind-service-type)
                 (service unattended-upgrade-service-type)
                 (service containerd-service-type)
                 (service docker-service-type)
                 (service xorg-server-service-type)
                 (service dhcpcd-service-type))
           %base-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
