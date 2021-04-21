# MIPS maths
# (c) 2016, GPL3
#
	.text
main:
	li	$t0, 45		# ucitaj 45 u registar $t0
	li	$t1, 11		# ucitaj 11 u registar $t1
	add	$a0, $t0, $t1	# $a0 = $t0 + $t1
				# Sistem ispisuje integer
	li	$v0, 1		# 1 znaci the print_int syscall
	syscall
				# Kazemo sistemu da se zaustavi
	li	$v0, 10		# 10 znaci exit syscalll
	syscall
