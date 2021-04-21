# jal and jr MIPS instructions
# (c) 2016, GPL3
#
		.data
string1:	.asciiz "Hello world!\n"
string2:	.asciiz "The second string\n"

		.text
main:		
		la $a0, string1	# Ispis prvog stringa
		li $v0, 4
		syscall

				# sledi poziv funkcije function() bez parametara.
				# Koristimo jal instrukciju. Tako se adresa
				# instrukcije koja sledi posle jal instrukcije
				# smesta u registar $ra (return address), a zatim
				# se skace na prvu instrukciju funkcije
		jal function

		li $v0, 4	# $a0 jos uvek sadrzi pokazivac na prvi string
		syscall		# Zar ne? Ispisimo ga ponovo

		li $v0, 10	# izlaz iz programa
		syscall


# Ova funkcija se poziva iz main(). Ona ispisuje string i zavrsava se
function:	
		la $a0, string2
		li $v0, 4
		syscall		# Ispis stringa

		jr $ra		# Povratak na instrukciju iz $ra registra
