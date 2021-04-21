
	.kdata
overflow: .asciiz "Arithmetic overflow\n"
saveat:	  .word 0		# Sacuvana vrednost $at registra
savea0:	  .word 0		# Sacuvana vrednost $at registra
	.ktext	0x80000180
handler:
	.set noat
	move $k1, $at
	sw $k1, saveat	# Cuvamo $at
	.set at
	sw $a0, savea0
	mfc0 $k0, $13
	srl $a0, $k0, 2
	andi $a0, $a0, 0xf
	bne $a0, 8,  restore
	bne $v0, 300, restore
	lw $a0, savea0	
	jal proizvod

restore:
    .set noat
    lw $k1, saveat          # Obnova $at registra
    move $at, $k1           
    .set at

    mfc0 $k0, $14           # Uzimamo EPC registar
    addiu $k0, $k0, 4       # Preskacemo instrukciju syscall
                            # Tako sto uvecamo EPC za jednu instrukciju
    mtc0 $k0, $14           # Resetujemo EPC registar
    
    mtc0 $0, $13            # Brisemo Cause registar
    
    mfc0 $k0, $12           # 
    ori  $k0, 0x1           # Omogucujemo prekide 
    mtc0 $k0, $12           # u status registru
    eret                    # povratak korisnickom programu na instrukciju sa adesom iz EPC


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
