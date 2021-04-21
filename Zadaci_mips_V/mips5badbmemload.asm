# Example program which causes an exception
# (c) 2016, GPL3

	.text
	.globl main
main:	la $t0, 0x00000000	# Ucitamo adresu memorijske lokacije koja ne postoji
	lw $a0, ($t0)		# Pokusamo da procitamo vrednost sa te lokacije
	
	li $v0, 10		# Izlaz
	syscall
