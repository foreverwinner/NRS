# MIPS multiplication
# (c) 2016, GPL3
#
	.text
main:
	li	$t0, 45		# Ucitaj 45 u registar $t0
	li	$t1, 10		# Ucitaj 10 u registar $t1
	mulo	$a0, $t0, $t1	# $a0 = $t0 * $t1
				# Sistem ispisuje integer
	li	$v0, 1		# 1 znaci the print_int syscall
	syscall
				# Kazemo sistemu da se zaustavi
	li	$v0, 10		# 10 znaci exit syscall
	syscall
