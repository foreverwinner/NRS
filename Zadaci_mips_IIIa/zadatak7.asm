.data
   str: .space 100
   porukaunos: .asciiz "Unesite string: "
   porukaispis: .asciiz "Rezultujuci string izgleda ovako: "
.text
   li $v0, 4
   la $a0, porukaunos
   syscall
   
   li $v0, 8
   la $a0, str
   li $a1, 100
   syscall
   
   li $t0, 0
whilebegin:
   lbu $t1, str($t0)
   beqz $t1, end
   beq $t1, 'a', samoglasnik
   beq $t1, 'e', samoglasnik
   beq $t1, 'i', samoglasnik
   beq $t1, 'o', samoglasnik
   beq $t1, 'u', samoglasnik
   b preskoci
samoglasnik:
   subu $t1, $t1, 32
   sb $t1, str($t0)
preskoci:
   add $t0, $t0, 1
   b whilebegin
 
end:
   li $v0, 4
   la $a0, porukaispis
   syscall
   
   li $v0, 4
   la $a0, str
   syscall

   li $v0, 10
   syscall

   
   
   
