

;; Set_room
.org 0x8004A124
.fill 0xB8
.org 0x8004A124
.area 0xB8

				;; Read Index
				la		$s0, pRdtIndex
				lh		$v0, Savegame_Room_no
				li		$v1, 8
				multu	$v1, $v0
				mflo	$v1
				addu	$s0, $v1, $s0			;; LBA Index

				;; Load RDT
				lw		$a0, 0x04($s0)			;; Sector
				lw		$a1, 0x00($s0)			;; Size
				lw		$a2, G_pRoom			;; Address
				jal		Cd_read_ex
				li		$a3, 0					;; Auto-Parse Index

				jal     Task_sleep				;; 2024 Is this still necessary?
				li      $a0, 1

				;; Update
				lw		$a3, 0x800D5310			;; CD.size_read
				lw      $v0, G_pRoom
				la      $s0, Global
				addiu   $v1, $v0, 8				;; RDT Index

				;; Complete
				j		0x8004A1DC
				nop

.endarea
