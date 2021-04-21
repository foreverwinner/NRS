# Example program which causes an exception
# (c) 2016, GPL3

	.data
X:	.word	7

	.text
	.globl main
main:	li $t0, 2147483647	# Stavi MAXINT u $t0
	li $t1, 5000
	add $a0, $t0, $t1	# Pokusaj da dodas 5000, treba da omane	

	li $v0, 10		# Izlaz
	syscall
