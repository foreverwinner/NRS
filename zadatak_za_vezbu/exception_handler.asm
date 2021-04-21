
	.kdata
saveat:	.word 0		# Sacuvana vrednost $at registra

	.ktext	0x80000180
handler:
	.set noat
	move $k1, $at
	sw $k1, saveat	# Cuvamo $at
	.set at

	
	
	
    .set noat
    lw $k1, saveat          # Obnova $at registra
    move $at, $k1           
    .set at

    mtc0 $0, $13            # Brisemo Cause registar
    mfc0 $k0, $12           # 
    ori  $k0, 0x1           # Omogucujemo prekide 
    mtc0 $k0, $12           # u status registru
    eret                    # povratak korisnickom programu na instrukciju sa adesom iz EPC



