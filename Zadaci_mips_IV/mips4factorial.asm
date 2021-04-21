# MIPS calling conventions and stack frames
# (c) 2016, GPL3

#Funkcija Factorial(x). Dobija jedini argument u $a0 i vraca  
#Factorial($a0) u registru $v0

		.text
main:		
		subu $sp, $sp, 24	# Pravimo nas stek frejm
		sw $ra, 20($sp)

		li $a0, 6			# Radimo Factorial(6)
		jal factorial		# Dobili smo rezultat u $v0,
		move $a0, $v0		# ispisujem rezultat
		li $v0, 1
		syscall

		li $v0, 10			# izlaz
		syscall


factorial:	
		subu $sp, $sp, 24	# Minimalna velicina frejma je 24 bajta
		sw $ra, 20($sp)		# Cuvamo povratnu adresu pre rekurzivnog poziva
		sw $a0, 0($sp)		# Cuvamo i nase parametre tako da mozem 
							# kasnje da mnozimo sa njima.
		bgt $a0, 1, notbasecase	# If arg > 1, nije osnovni slucaj pa preskoci
basecase:	
		li $v0, 1			# Osnovni slucaj: fact(1) je 1.
		b factreturn		# Sada mozemo vratiti rezultat.

notbasecase:	
		subi $a0, $a0, 1	# Nije osnovni slucaj, pa oduzimamo 1
		jal factorial		# parametar i poziv druge funkcije.
							# Sada poziv vraca rezultat u $v0
		lw $a0, 0,($sp)		# Ucitamo ponovo nas originalni parametar sa stek frejma
		mulo $v0, $a0, $v0	# result = nas parametar * Factorial(nas parametar - 1)

factreturn:	
		lw $ra, 20($sp)		# Obnavljamo povratnu adresu
		addu $sp, $sp, 24	# Unistavamo frejm
		jr $ra				# i vracamo se pozivaocu
