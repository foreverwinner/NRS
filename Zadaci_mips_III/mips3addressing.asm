# Pointers and dereferencing in MIPS
# (c) 2016, GPL3

		.data
myarray:	.word 7 9 11 13		# Cetiri integer-a u nizu
newline:	.asciiz "\n"

		.text
main:
		la $t0, myarray		# Ucitaj adresu prvog int-a u nizu
		move $a0, $t0		# Ispisi adresu prvog int-a u nizu
		li $v0, 1			# Primetiti da se ispisuje adresa, a ne broj 7
		syscall

		la $a0, newline	# Prelazak u novi red
		li $v0, 4
		syscall
						# Sada koristimo $t0 kao pokazivac, i pristupamo mu
						# da bismo iz memorije preuzeli vrednost sa te adrese.
		lw $a0, ($t0)	# Ovo ispisuje broj 7, a ne njegovu adresu
		li $v0, 1		
		syscall

		la $a0, newline	# Prelazak u novi red
		li $v0, 4
		syscall
		
						# Sada koristimo indeksno adresiranje da pristupimo vrednosti myarray[1].
						# Ovde mozemo da imenujemo baznu adresu,
		li $t0, 4		# i da koristimo registar da bismo odredili offset od bazne adrese.
		lw $a0, myarray($t0)	# Sada uzimamo broj 9 i ispisujemo ga. Primetiti daand prints it out. Note we had to
		li $v0, 1			# Primetiti da je offset u odnosu na bazu 4, jer je word  baze , as a word
		syscall				# velicine 4 bajta, tj. morali smo da preskocimo 4 bajta od broja "7" i dodjemo do broja "9".

		la $a0, newline		# Prelazak u novi red
		li $v0, 4
		syscall
					# Sada ce petlja ispisati sve brojeve niza.
					# Registar $t0 sadrzi offset, a registar $a0 dobija vrednost sa te pozicije. 
		la $t0, 0	# Inicijalizacija registra $t0, nema offseta od bazne adrese niza.

loop:		
		lw $a0, myarray($t0)	# Dohvati vrednost myarray[n]
		li $v0, 1				# Ispis vrednosti
		syscall
		la $a0, newline			# Prelazak u novi red
		li $v0, 4
		syscall

		addi $t0, $t0, 4		# Pomeranje indeksa na offset sledeceg broja.
		blt $t0, 16, loop		# Vrati se na izvrsenje petlje ako $t0 < 16. Zasto 16? 4 broja, 4 bajta svaki.
	

		li $v0, 10				# Izlaz iz programa.
		syscall
