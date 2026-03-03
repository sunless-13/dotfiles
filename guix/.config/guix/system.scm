(use-modules (gnu)
             (gnu packages android)
             (gnu system accounts))
(use-service-modules networking desktop containers)

;; main config
(operating-system
    ;; personal
    (host-name "sunless")
    (timezone "Africa/Nairobi")
    (locale "en_US.utf8")
    (keyboard-layout (keyboard-layout "us"))

    ;; grub
    (bootloader
     (bootloader-configuration
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
        (type "ext4")))
      %base-file-systems))

    ;; users
    (users
     (cons
      (user-account
       (name "sunless")
       (group "users")
       (supplementary-groups
        '("wheel" "audio" "video" "adbusers" "cgroup" "input")))
      %base-user-accounts))

    ;; packages
    (packages %base-packages)

    ;; services
    (services
     (append
      (list
       (service dhcpcd-service-type)
       (service ntp-service-type)
       ;; (service iptables-service-type)
       (service sane-service-type)
       (service elogind-service-type)
       (service rootless-podman-service-type
                (rootless-podman-configuration
                 (subgids
                  (list (subid-range (name "sunless"))))
                 (subuids
                  (list (subid-range (name "sunless")))))
                )
       (udev-rules-service 'android android-udev-rules
                           #:groups '("adbusers"))
       )%base-services))
    
    ;; Allow resolution of '.local' host names with mDNS.
    (name-service-switch %mdns-host-lookup-nss))
