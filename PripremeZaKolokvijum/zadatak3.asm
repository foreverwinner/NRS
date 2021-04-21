	.data
poruka1: .asciiz "Uneti string 1: "
poruka2: .asciiz "Uneti string 2: "
poruka3: .asciiz "Rezultujuci string je: "
poruka4: .asciiz "Duzina string je: "
		.text
main:
	subi $sp, $sp, 324 #prvi string od 24, drugi string od 124, rezultujucu od 224
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 20($sp)
	
	li $v0, 4
	la $a0, poruka1
	syscall
	li $v0, 8
	la $a0, 24($sp)
	li $a1, 100
	syscall

	li $v0, 4
	la $a0, poruka2
	syscall
	li $v0, 8
	la $a0, 124($sp)
	li $a1, 100
	syscall
	
	la $a0, 24($sp) #Prosledjivanje parametara funkciji....
	la $a1, 124($sp)
	la $a2, 224($sp)
	jal funkcija
	
	li $v0, 4
	la $a0, poruka3
	syscall
	
	li $v0, 4
	la $a0, 224($sp)
	syscall
	
	li $v0, 4
	la $a0, poruka4
	syscall

	la $a0, 224($sp)
	li $v0, 300
	syscall

	move $a0, $v0
	li $v0, 1
	syscall	
	
kraj:
	li $v0, 10
	syscall
	
funkcija:
	subi $sp, $sp, 24 	#Pravimo stack frame
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 20($sp)
	
	li $t5, 1
	li $t3, 0 	#oznacavace nam string iz koga se karakter upisuje...
petlja:
	lbu $t0, ($a0) 	#Preuzimamo znak iz prvog stringa
	lbu $t1, ($a1) 	#Preuzimamo znak iz drugog stringa
	beq $t0, '\n', kopirajDrugi
	beq $t1, '\n', kopirajPrvi

	beq $t3, 0, prvi
	sb $t1, ($a2)
	b nastavi
prvi:
	sb $t0, ($a2)
nastavi:
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	addi $a2, $a2, 1
	sub $t3, $t5, $t3 #obrcemo $t3
	b petlja
	
kopirajPrvi:
	lbu $t0, ($a0)
	beq $t0, '\n', kraj_funkcije
	sb $t0, ($a2)
	addi $a0, $a0, 1
	addi $a2, $a2, 1
	b kopirajPrvi
		
kopirajDrugi:
	lbu $t1, ($a1)
	beq $t1, '\n', kraj_funkcije
	sb $t1, ($a2)
	addi $a1, $a1, 1
	addi $a2, $a2, 1
	b kopirajDrugi

kraj_funkcije:
	li $t0, 0
	sb $t0, ($a2)
	
	lw $ra, 20($sp)
	lw $a3, 12($sp)
	lw $a2, 8($sp)
	lw $a1, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 24
	jr $ra
