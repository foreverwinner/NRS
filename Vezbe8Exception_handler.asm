
	.kdata
overflow: .asciiz "Arithmetic overflow"
saveat:	  .word 0		# Sacuvana vrednost $at registra

	.ktext	0x80000180
handler:
	.set noat
	move $k1, $at
	sw $k1, saveat	# Cuvamo $at
	.set at

	mfc0 $k0, $13
	srl $a0, $k0, 2
	andi $a0, $a0, 0xf
	bne $a0, 9,  restore

        li $v0, 4
        la $a0, overflow
        syscall
    	    	
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
