.data
  porukaunos: .asciiz "Unesite neoznaceni broj: "
  porukaispis: .asciiz "Broj cifara je: "
.text
   li $v0, 4
   la $a0, porukaunos
   syscall
   
   li $v0, 5
   syscall
   move $t0, $v0

   li $t1, 0
dowhilebegin:
   divu $t0, $t0, 10
   addi $t1, $t1, 1
   bnez $t0, dowhilebegin   
dowhileend:

   li $v0, 4
   la $a0, porukaispis
   syscall

   li $v0, 1
   move $a0, $t1
   syscall

   li $v0, 10
   syscall
