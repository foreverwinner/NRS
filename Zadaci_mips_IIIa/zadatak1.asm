.data
   porukaunos: .asciiz "Unesite broj: "
   porukaveci: .asciiz "Uneti broj je veci od 0 "
   porukamanji: .asciiz "Uneti broj je manji ili jednak sa 0 "
.text
   li $v0, 4
   la $a0, porukaunos
   syscall
   
   li $v0, 5
   syscall
if:   
   blez $v0, else
   li $v0, 4
   la $a0, porukaveci
   syscall
   b endif
else:
   li $v0, 4
   la $a0, porukamanji
   syscall
endif:
      
   li $v0, 10
   syscall
   
