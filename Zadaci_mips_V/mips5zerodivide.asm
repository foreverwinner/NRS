# Example program which causes an exception
# (c) 2016, GPL3

	.text
	.globl main
main:	li $t1, 300
	li $t0, 0
	div $a0, $t1, $t0	# Uradi $a0 = $t1 / $t0

	li $v0, 1		# Ispisi rezultat kao ceo broj
	syscall

	li $v0, 10		# Izlaz
	syscall
