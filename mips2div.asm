# MIPS division
# (c) 2016, GPL3
#
	.text
main:
	li	$t0, 18		# Ucitaj 18 u registar $t0
	li	$t1, 3		# Ucitaj 3 u registar $t1
	div	$a0, $t0, $t1	# $a0 = $t0 + $t1
				# Sistem ispisuje integer
	li	$v0, 1		# 1 znaci the print_int syscall
	syscall
				# Kazemo sistemu da se zaustavi
	li	$v0, 10		# 10 znaci exit syscall
	syscall
