# Shift program
# (c) 2010, GPL3
#
	.text
main:
	li	$t0, 3		# Ucitaj 3 u $t0
	sll	$a0, $t0, 1	# pomeri $t0 ulevo za 1 poziciju
				# Sistem ispisuje integer
	li	$v0, 1		# 1 znaci the print_int syscall
	syscall
				# Kazemo sistemu da se zaustavi
	li	$v0, 10		# 10 znaci exit syscall
	syscall
