# Example program which causes an exception
# (c) 2016, GPL3

	.text
	.globl main
main:	la $t0, 0x00000000	# Ucitaj losu memorijsku adresu
	sw $a0, ($t0)		# pokusaj da sacuvas nesto na tu lokaciju

	li $v0, 10		# Izlaz
	syscall
