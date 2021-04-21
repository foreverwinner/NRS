# Basic MIPS branch instructions
# (c) 2016, GPL3


			# Program ispisuje brojeve od 1 do 20 u WHILE petlji.
		.data
newline:	.asciiz	"\n"

		.text
main:	li $t0, 1					# Pocni od 1
top_of_loop:	
		bgt $t0, 20, end_of_loop	# Prekini ako $t0 predje preko limita.exceeds the loop limit
		move $a0, $t0			# print_int($t0)
		li $v0, 1		
		syscall

		la $a0, newline			# Prelazak u novi red
		li $v0, 4
		syscall

		add $t0, $t0, 1			# $t0++
		b top_of_loop			# vracanje na pocetak petlje

end_of_loop:	
		li $v0, 10				# exit syscall
		syscall
