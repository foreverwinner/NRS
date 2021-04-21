.data
   porukaunos: .asciiz "Unesite dva broja: "
   porukanzd: .asciiz "NZD je: "
.text
   li $v0, 4
   la $a0, porukaunos
   syscall
   
   li $v0, 5
   syscall
   move $t0, $v0

   li $v0, 5
   syscall
   move $t1, $v0
   
whilebegin:
   beq $t0, $t1, whileend
   if:
      blt $t0, $t1, else
      sub $t0, $t0, $t1
      b whilebegin
   else:
      sub $t1, $t1, $t0
      b whilebegin
whileend:
  
   li $v0, 4
   la $a0, porukanzd
   syscall
   
   li $v0, 1
   move $a0, $t0
   syscall

   li $v0, 10
   syscall
   
   
