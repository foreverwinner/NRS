
	.kdata
saveat:	.word 0		# Sacuvana vrednost $at registra
savea0:	.word 0		# Sacuvana vrednost $at registra

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
	jal duzinaStringa

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

duzinaStringa:
	subi $sp, $sp, 24   #pravimo stack frame
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 20($sp)

	li $v0, 0 	    #broj karaktera
while:
	lbu $a1, ($a0)	
	beqz $a1, endwhile
	addi $v0, $v0, 1
	addi $a0, $a0, 1
	b while
	
endwhile:	
	lw $ra, 20($sp)
	lw $a3, 12($sp)
	lw $a2, 8($sp)
	lw $a1, 4($sp)
	lw $a0, 0($sp)
	addi $sp, $sp, 24
	jr $ra
