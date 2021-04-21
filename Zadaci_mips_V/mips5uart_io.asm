# This program does polling on the receive and transmit device registers
# on the MARS Keyboard and Display Simulator. Any input received from
# the simulated keyboard is echoed to the simulated display.
# (c) 2016, GPL3

		.data
recv_data:	.word 0xffff0004	# Registar koji sadrzi primljene karaktere
recv_ctrl:	.word 0xffff0000	# Registar koji signalizira kada su podaci dostupni
send_data:	.word 0xffff000c	# Registar koji sadrzi podatke za slanje
send_ctrl:	.word 0xffff0008	# Registar koji signalizira kada podaci mogu da se salju


	.text
main:	lw	$t0, recv_data		# Postavljamo 4 registra da sadrze adrese registara uredjaja
	lw	$t1, recv_ctrl			
	lw	$t2, send_data
	lw	$t3, send_ctrl

readloop: lw $t5, ($t1)			# Proveravamo prijemni kontrolni registar
	  beq $t5, $0, readloop		# Vrtimo se u petlji dok je nula
	  lw $t5, ($t0)				# preuzimamo karakter iz prijemnog registra

	  move $a0, $t5             # kontrola, ispisujemo karakter kao ceo broj
	  li $v0, 1
	  syscall

writeloop: lw $t6, ($t3)		# Proveravamo da li mozemo da ispisemo karakter
	   bne $t6, 1, writeloop	# vrtimo se u petlji dok ne postane 1
	   sw $t5, ($t2)			# Smestamo karakter u predajni registar
	   b readloop				# i opet Jovo nanovo...
