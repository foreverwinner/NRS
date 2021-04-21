	.data
unos: .asciiz "Unesite elemente niza\n"
unos1: .asciiz "Unesite broj: "
sume: .asciiz "Niz parcijalnih suma je: "
	.text
main:
	subu $sp, $sp, 828 	#kreiramo stack frame
	sw $ra, 20($sp)
	
	la $a0, unos
	li $v0, 4
	syscall
	
	li $t0, 0 		#broj_elemenata
	addi $t1, $sp, 28 	#pocetak niza
	
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
	addi $t0, $t0, 1        #povecavamo broj unetih elemenata niza
	b loop  		#prelazimo na unos novog broja
	
end_of_loop:
        sw $t0, 24($sp) 	#pamtimo broj elemenata niza
	addi $a0, $sp, 28	#prvi parametar je adresa niza
	move $a1, $t0		#drugi parametar je broj elemenata niza
	addi $a2, $sp, 428	#treci parametar je adresa drugog niza
	jal parcijalneSume 	#racunamo parcijalne sume
	
	la $a0, sume
	li $v0, 4
	syscall  		#Ispis teksta: Niz parcijalnih suma je:
	
	lh $t1, 24($sp)
	addi $t0, $sp, 428
stampanje: 
	beqz $t1, krajStampe
	lw $a0, ($t0)
	li $v0, 1
	syscall			#ispisemo jednu sumu
	
	li, $a0, 32
	li $v0, 11
	syscall			#ispisemo razmak
	
	addi $t0, $t0, 4  	#predjemo na sledeci element niza
        subi $t1, $t1, 1	#smanjimo broj elemenata za stampu
        b stampanje

krajStampe:
	la $ra, 20($sp)
	addi $sp, $sp, 828 	#unistavamo stack frame
	li $v0, 10
	syscall			#kraj programa
	
parcijalneSume:
	subu $sp, $sp, 24
	sw $ra, 20($sp)
	sw $a0, ($sp)    	#adresa niza
	sw $a1, 4($sp)  	#broj elemenata
	sw $a2, 8($sp)  	#adresa drugog niza
	
	li $v0, 0 		#trenutna suma
	li $t0, 0 		#tekuci element
func_loop:
	beq $t0, $a1, end_func #da li smo stigli do kraja?
	lw $t1, ($a0)          #ako ne, ucitavamo broj iz niza
	add $v0, $v0, $t1      #pravimo parcijalnu sumu
	sw $v0, ($a2)	       #smestamo sumuu niz
        addi $t0, $t0, 1       #povecavamo indeks elementa
	addi $a0, $a0, 4       #prelazimo na sledeci broj u prvom nizu
	addi $a2, $a2, 4       #prelazimo na sledeci broj u drugom nizu
	b func_loop

end_func:
	lw $ra, 20($sp)
	la $a0, ($sp)
	la $a1, 4($sp)
	addu $sp, $sp, 24
	jr $ra
