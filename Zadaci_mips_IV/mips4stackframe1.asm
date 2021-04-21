# jal and jr MIPS instructions
# (c) 2016, GPL3
#
		.data
string1:	.asciiz "Hello world!\n"
string2:	.asciiz "The second string\n"

		.text
main:		
		subu $sp, $sp, 24	# Kako je i main() funkcija prvo sto radimo je 
		sw $ra, 20($sp)		# da napravimo stek frejm.

		la $a0, string1		# Ispis prvog stringa
		li $v0, 4
		syscall

		sw $a0, 0($sp)		# Pre poziva funkcije sacuvamo $a0 registar
							# u frejm, tako da ne bude unisten.

		jal function		# Sada pozivanje funkcije.
		lw $a0, 0($sp)		# Vratili smo se nazad pa sada ponovo ucitamo nas $a0

		li $v0, 4			# Ponovni ispis prvog stringa.
		syscall

		li $v0, 10			# Izlaz iz programa
		syscall				# nema potrebe da cistimo stek frejm!


# Ova funkcija se poziva iz main(). Ona ispisuje string i zavrsava se
function:	
		subu $sp, $sp, 24	# Pravimo stek frejm
		sw $ra, 20($sp)
	
		la $a0, string2		# Ispis drugog stringa
		li $v0, 4
		syscall

		lw $ra, 20($sp)		# Ponovo ucitamo povratnu adresu
		addu $sp, $sp, 24	# Unistimo nas stek frejm i
		jr $ra				# vracamo se pozivaocu
