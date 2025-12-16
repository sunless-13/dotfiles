(use-modules (gnu)
						 (nongnu packages linux)
						 (nongnu system linux-initrd))
(use-service-modules desktop admin docker xorg)

(define %my-desktop-services
	(modify-services %desktop-services
									 (delete gdm-service-type)))

;; main config
(operating-system
	;; wifi
	(kernel linux)
	(initrd microcode-initrd)
	(firmware (cons* iwlwifi-firmware
									 %base-firmware))

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

	;; packages
	(packages %base-packages)

	;; services
	(services
	 (append (list
						(service bluetooth-service-type)
						(service containerd-service-type)
						(service docker-service-type))
					 %my-desktop-services))


	;; Allow resolution of '.local' host names with mDNS.
	(name-service-switch %mdns-host-lookup-nss))
