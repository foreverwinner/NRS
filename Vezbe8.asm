	.data
unos: .asciiz "Unesite elemente niza\n"
unos1: .asciiz "Unesite broj: "
proiz: .asciiz "Proizvod brojeva je: "
	.text

main:
	subu $sp, $sp, 228 #kreiramo stack frame
	sw $ra, 20($sp)
	
	la $a0, unos
	li $v0, 4
	syscall
	
	li $t0, 0 #broj_elemenata
	addi $t1, $sp, 28 #pocetak niza
	
loop:
	beq $t0, 100, end_of_loop
	
	la $a0, unos1
	li $v0, 4
	syscall # ispis stringa: Unesite element niza
	
	li $v0, 5
	syscall #ucitavamo broj
	
	beq $v0, $0, end_of_loop #ako je uneta nula, kraj unosa
	sh $v0, ($t1)            #smestamo broj u niz
	addi $t1, $t1, 2         #prelazimo na sledece mesto u nizu
	addi $t0, $t0, 1         #povecavamo broj unetih elemenata niza
	b loop  #prelazimo na unos novog broja
	
end_of_loop:
        sw $t0, 24($sp) #pamtimo broj elemenata niza
	move $a1, $t0
	addi $a0, $sp, 28
	jal proizvod #racunamo proizvod
	
	move $t0, $v0
	
	la $a0, proiz
	li $v0, 4
	syscall  #Ispis teskata: Proizvod brojeva je
	
	move $a0, $t0
	li $v0, 1
	syscall #ispis proizvoda

	la $ra, 20($sp)
	addi $sp, $sp, 228 #unistavamo stack frame
	li $v0, 10
	syscall
	
proizvod:
	subu $sp, $sp, 24
	sw $ra, 20($sp)
	sw $a0, ($sp)    #adresa niza
	sw $a1, 4($sp)   #broj elemenata
	
	li $v0, 1 #proizvod
	li $t0, 0 #tekuci element
func_loop:
	beq $t0, $a1, end_func #da li smo stigli do kraja?
	lh $t1, ($a0)          #ako ne, ucitavamo broj
        addi $t0, $t0, 1       #povecavamo broj elenta
	addi $a0, $a0, 2       #prelazimo na sledeci broj
	mulo $v0, $v0, $t1     #mnozimo brojeve
	b func_loop

end_func:

	lw $ra, 20($sp)
	la $a0, ($sp)
	la $a1, 4($sp)
	addu $sp, $sp, 24
	jr $ra
