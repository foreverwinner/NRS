	.data
unos: .asciiz "Unesite elemente nizova\n"
unos1: .asciiz "Unesite element prvog niza: "
unos2: .asciiz "Unesite element drugog niza: "
proiz: .asciiz "Proizvod brojeva je: "
novired: .asciiz "\n"
	.text
main:
	subu $sp, $sp, 828 	#kreiramo stack frame za 2 niza 
				#svaki niz je od po 100 brojeva od 4 bajta
	sw $ra, 20($sp)
	
	la $a0, unos
	li $v0, 4
	syscall
	
	li $t0, 0 		#broj_elemenata
	addi $t1, $sp, 28 	#pocetak niza 1
	addi $t2, $sp, 428	#pocetak niza 2
loop:
	beq $t0, 100, end_of_loop
	
	la $a0, unos1
	li $v0, 4
	syscall 		#ispis stringa: Unesite element niza
	li $v0, 5
	syscall 		#ucitavamo broj
	beq $v0, $0, end_of_loop#ako je uneta nula, kraj unosa
	sw $v0, ($t1)           #smestamo broj u niz
	addi $t1, $t1, 4        #prelazimo na sledece mesto u nizu
	
	la $a0, unos2
	li $v0, 4
	syscall 		#ispis stringa: Unesite element niza
	li $v0, 5
	syscall 		#ucitavamo broj
	sw $v0, ($t2)           #smestamo broj u niz
	addi $t2, $t2, 4        #prelazimo na sledece mesto u nizu
	
	addi $t0, $t0, 1        #povecavamo broj unetih elemenata niza
	b loop  		#prelazimo na unos novog broja
	
end_of_loop:
        sw $t0, 24($sp) 	#pamtimo broj elemenata niza
	addi $a0, $sp, 28	#prvi parametar je adresa niza 1
	addi $a1, $sp, 428	#drugi parametar je adresa niza 2
	jal proizvod 		#racunamo proizvod
		
	move $t0, $v0		#Rezultat privremeno smestimo u $t0
	
	la $a0, proiz
	li $v0, 4
	syscall  		#Ispis teksta: Proizvod brojeva je
	move $a0, $t0
	li $v0, 1
	syscall 		#ispis proizvoda

	#sistemski poziv
	addi $a0, $sp, 28	#prvi parametar je adresa niza 1
	addi $a1, $sp, 428	#drugi parametar je adresa niza 2
	li $v0, 300
	syscall

	move $t0, $v0		#Rezultat privremeno smestimo u $t0
	la $a0, novired
	li $v0, 4
	syscall  		#Ispis teksta: Proizvod brojeva je
	la $a0, proiz
	li $v0, 4
	syscall  		#Ispis teksta: Proizvod brojeva je

	move $a0, $t0
	li $v0, 1
	syscall 		#ispis proizvoda

	la $ra, 20($sp)
	addi $sp, $sp, 228 	#unistavamo stack frame
	li $v0, 10
	syscall			#kraj programa
	
proizvod:
	subu $sp, $sp, 24
	sw $ra, 20($sp)
	sw $a0, ($sp)    	#adresa niza
	sw $a1, 4($sp)  	#broj elemenata
	
	li $v0, 0  		#proizvod
func_loop:
	lw $t0, ($a0)		#Uzimamo element iz prvog niza
	beqz $t0, end_func 	#da li smo stigli do kraja?
	lw $t1, ($a1)		#Uzimamo element iz prvog niza
	mul $t0, $t0, $t1
        add $v0, $v0, $t0
	addi $a0, $a0, 4       #prelazimo na sledeci broj
	addi $a1, $a1, 4       #prelazimo na sledeci broj
	b func_loop

end_func:
	lw $ra, 20($sp)
	la $a0, ($sp)
	la $a1, 4($sp)
	addu $sp, $sp, 24
	jr $ra
