	.data
unosK: .asciiz "Unesite broj K: "
unos: .asciiz "Unesite elemente niza\n"
unos1: .asciiz "Unesite broj: "
result: .asciiz "Broj deljivih brojeva je: "
	.text
main:
	subu $sp, $sp, 224 	#kreiramo stack frame
	sw $ra, 20($sp)

	la $a0, unosK
	li $v0, 4
	syscall 		#ispis stringa: Unesite broj K
	li $v0, 5
	syscall 		#ucitavamo broj K
        move $t2, $v0
			
	la $a0, unos
	li $v0, 4
	syscall
	
	li $t0, 0 		#broj_elemenata
	addi $t1, $sp, 24 	#pocetak niza
	
loop:
	beq $t0, 100, end_of_loop
	
	la $a0, unos1
	li $v0, 4
	syscall 		#ispis stringa: Unesite element niza
	
	li $v0, 5
	syscall 		#ucitavamo broj
	
	beq $v0, $0, end_of_loop#ako je uneta nula, kraj unosa
	sh $v0, ($t1)           #smestamo broj u niz
	addi $t1, $t1, 2        #prelazimo na sledece mesto u nizu
	addi $t0, $t0, 1        #povecavamo broj unetih elemenata niza
	b loop  		#prelazimo na unos novog broja
	
end_of_loop:
	addi $a0, $sp, 24	#prvi parametar je adresa niza
	move $a1, $t0		#drugi parametar je broj elemenata niza
	move $a2, $t2
	jal brojDeljivih 		#racunamo broj deljivih
	
	move $t0, $v0		#Rezultat privremeno smestimo u $t0
	
	la $a0, result
	li $v0, 4
	syscall  		#Ispis teksta: Broj deljivih brojeva je
	
	move $a0, $t0
	li $v0, 1
	syscall 		#ispis broja deljivih

	la $ra, 20($sp)
	addi $sp, $sp, 224 	#unistavamo stack frame
	li $v0, 10
	syscall			#kraj programa
	
brojDeljivih:
	subu $sp, $sp, 24
	sw $ra, 20($sp)
	sw $a0, 0($sp)    	#adresa niza
	sw $a1, 4($sp)  	#broj elemenata
	sw $a2, 8($sp)  	#broj K
		
	li $v0, 0 		#broj deljivih
	li $t0, 0 		#tekuci element
func_loop:
	beq $t0, $a1, end_func #da li smo stigli do kraja?
	lh $t1, ($a0)          #ako ne, ucitavamo broj iz niza
        addi $t0, $t0, 1       #povecavamo indeks elementa
	addi $a0, $a0, 2       #prelazimo na sledeci broj
	rem $t2, $t1, $a2
	bnez $t2, func_loop
	addi $v0, $v0, 1
	b func_loop

end_func:

	lw $ra, 20($sp)
	la $a0, 0($sp)
	la $a1, 4($sp)
	la $a2, 8($sp)
	addu $sp, $sp, 24
	jr $ra
