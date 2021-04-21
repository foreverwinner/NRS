.data
   porukaunos: .asciiz "Unesite tri broja: "
   porukanajveci: .asciiz "Najveci broj je: "

   
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
   
   li $v0, 5
   syscall
   move $t2, $v0
if1:
   blt $t0, $t1, else1
   if2:
      blt $t0, $t2, else2
      move $t3, $t0
      b endif1
   else2:
      move $t3, $t2
      b endif1
else1:      
   if3:
      blt $t1, $t2, else2
      move $t3, $t1
      b endif1
   else3:
      move $t3, $t2
endif1:
   li $v0, 4
   la $a0, porukanajveci
   syscall
   
   li $v0, 1
   move $a0, $t3
   syscall
   
   li $v0, 10
   syscall
   
