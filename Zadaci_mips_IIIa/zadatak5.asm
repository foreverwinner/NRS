.data 
porukaunosn: .asciiz "Unesite broj n: "
porukaunos: .asciiz "Unesite broj: "
porukaispis: .asciiz "Najmanji broj je: "
.text
   li $v0, 4
   la $a0, porukaunosn
   syscall
   
   li $v0, 5
   syscall
   move $t0, $v0
   
   #Ucitavamo prvi broj i proglasimo ga najmanjim
   li $v0, 4
   la $a0, porukaunos
   syscall
   li $v0, 5
   syscall
   move $t2, $v0 #$t2 je minimum
   #for petlja ide od drugog broja jer je prvi vec ucitan
   li $t1, 2
forbegin:
   bgt $t1, $t0, forend
   li $v0, 4
   la $a0, porukaunos
   syscall
   li $v0, 5
   syscall
if:  
   blt $t2, $v0, endif
   move $t2, $v0
endif:
   addi $t1, $t1, 1
   b forbegin  
forend:
 
   li $v0, 4
   la $a0, porukaispis
   syscall
   
   li $v0, 1
   move $a0, $t2
   syscall
   
   li $v0, 10
   syscall
