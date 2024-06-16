id:: 64d605c2-5e72-486d-9d5d-fa51d49cc916
> fdisk -l  [盘]

	- ```shell
	  (tob_env) root@n56-112-105:/run/containerd# fdisk  -l /dev/nvme0n1
	  Disk /dev/nvme0n1: 3.5 TiB, 3840755982336 bytes, 7501476528 sectors
	  Units: sectors of 1 * 512 = 512 bytes
	  Sector size (logical/physical): 512 bytes / 512 bytes
	  I/O size (minimum/optimal): 512 bytes / 512 bytes
	  Disklabel type: gpt
	  Disk identifier: EC30D394-8D87-4FDA-82D9-F5A471C00BE9
	  
	  Device             Start        End    Sectors   Size Type
	  /dev/nvme0n1p1      2048     999423     997376   487M EFI System
	  /dev/nvme0n1p2    999424    3999743    3000320   1.4G Linux filesystem
	  /dev/nvme0n1p3   3999744  404000767  400001024 190.8G Linux filesystem
	  /dev/nvme0n1p4 404000768 7501475839 7097475072   3.3T Linux filesystem
	  (tob_env) root@n56-112-105:/run/containerd# fdisk  -l /dev/nvme1n1
	  Disk /dev/nvme1n1: 3.5 TiB, 3840755982336 bytes, 7501476528 sectors
	  Units: sectors of 1 * 512 = 512 bytes
	  Sector size (logical/physical): 512 bytes / 512 bytes
	  I/O size (minimum/optimal): 512 bytes / 512 bytes
	  Disklabel type: gpt
	  Disk identifier: E5C32534-0955-43FF-BE6B-382ACEC5E4A6
	  
	  Device         Start        End    Sectors  Size Type
	  /dev/nvme1n1p1  2048 7501475839 7501473792  3.5T Linux filesystem
	  ```
- > lsblk -f       blkid
	- ```shell
	  (tob_env) root@n56-112-105:/run/containerd# lsblk -f
	  NAME        FSTYPE LABEL     UUID                                 MOUNTPOINT
	  nvme1n1
	  └─nvme1n1p1 ext4   xxx 07b998b3-3f6f-46cb-a5f8-6e5b3ed62908 /data01
	  nvme0n1
	  ├─nvme0n1p1 vfat             FD73-110C                            /boot/efi
	  ├─nvme0n1p2 ext2             be9a3322-9d6e-4a84-a6f3-6c11ae551e37 /boot
	  ├─nvme0n1p3 ext4             04761240-f42b-4bfd-a521-3cab40340d39 /
	  └─nvme0n1p4 ext4   xxx 7562df2b-fd9d-4e42-9a82-eb306ddc5e01 /var/lib/kubelet/pods/b8183964-c613-44da-be5a-365b663923b6/volumes/kubernetes.io~local-volume/raftlog-local-vol-n56-112-105-0
	  nvme7n1
	  └─nvme7n1p1 ext4   xxx 216185bf-b74d-4978-a451-c2a07b1dd990 /data02
	  ```
