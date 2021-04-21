# Multiplication with shifts
# (c) 2016, GPL3
#
	.text
main:
	li	$t0, 5		# Ucitaj 5 u $t0
	sll	$t1, $t0, 1	# pomeri $t0 ulevo za 1 poziciju
	sll	$t2, $t0, 3	# pomeri $t0 ulevo za 3 poziciju
	add	$a0, $t1, $t2	# Saberi dva pomerena rezultata
				# Sistem ispisuje integer
	li	$v0, 1		# 1 znaci the print_int syscall
	syscall
				# Kazemo sistemu da se zaustavi
	li	$v0, 10		# 10 znaci exit syscall
	syscall
