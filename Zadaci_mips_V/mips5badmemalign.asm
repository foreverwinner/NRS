# Example program which causes an exception
# (c) 2016, GPL3

	.data
X:	.word	7

	.text
	.globl main
main:	la $t0, X		# Ucitaj adresu od X u $t0
	li $a0, 45		
	sw $a0, ($t0)		# Sacuvaj vrednost 45 u X, ovo ce raditi 

	addi $t0, $t0, 1	# pokvari pode[enje za rec,  uvecaj $t0 za 1 bajt
	sw $a0, ($t0)		# Sacuvaj vrednost 45 u X, ovo bi trebalo da ne uspe 

	li $v0, 10		# Izlaz
	syscall
