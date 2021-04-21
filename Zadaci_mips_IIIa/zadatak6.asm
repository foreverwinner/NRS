.data 
niz: .space 400
porukaunosn: .asciiz "Unesite broj n: "
porukaunos: .asciiz "Unesite broj: "
porukaispis: .asciiz "Brojevi koji se zavrsavaju sa 0 su: "
razmak: .asciiz " "
.text
   li $v0, 4
   la $a0, porukaunosn
   syscall
   li $v0, 5
   syscall
   move $t0, $v0
   
   #for petlja ide od drugog broja
   li $t1, 0 # brojac
   li $t2, 0 # udaljenost
forbegin:
   beq $t1, $t0, forend
   li $v0, 4
   la $a0, porukaunos
   syscall
   li $v0, 5
   syscall
   sw $v0, niz($t2)
   addi $t1, $t1, 1
   addi $t2, $t2, 4
   b forbegin  
forend:

   li $v0, 4
   la $a0, porukaispis
   syscall
   li $t1, 0
   li $t2, 0
for2begin:
   beq $t1, $t0, for2end
   lw $t3, niz($t2)
   if: 
      rem $t4, $t3, 10
      bnez $t4, ifend
      li $v0, 1
      move $a0, $t3
      syscall
      li $v0, 4
      la $a0, razmak
      syscall
   ifend:
   addi $t1, $t1, 1
   addi $t2, $t2, 4
   b for2begin
for2end:

   li $v0, 10
   syscall
