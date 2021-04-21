# MIPS load/store instructions
# (c) 2016, GPL3
#
	.data
num1:	.word	7		# Smesti 7 kao word u num1 lokaciju
num2:	.word	6		# num2 = 6
num3:	.half	-10		# Smesti -10 u 16-bitnu lokaciju num3
num4:	.half	3		# num4 = 3
num5:	.byte	64		# num5 je duzine 1 byte
num6:	.byte	1

#
# Izracunati num1 = num1 * num2 + num3
#

	.text
main:
	lw	$t0, num1	# $t0 = num1
	lw	$t1, num2	# $t0 = num2
	lh	$t2, num3	# $t2 = num3
	mulo	$t3, $t0, $t1	# $t3 = $t0 + $t1, i.e. 7 * 6 = 42
	add	$t3, $t3, $t2	# $t3 = $t3 + $t2, i.e. 42 + -10 = 32
	sw	$t3, num1	# num1 = $t3

				# Ispis rezultata
	move	$a0, $t3
	li	$v0, 1		# 1 znaci the print_int syscall
	syscall
				# Kazemo sistemu da se zaustavi
	li	$v0, 10		# 10 znaci exit syscall
	syscall
