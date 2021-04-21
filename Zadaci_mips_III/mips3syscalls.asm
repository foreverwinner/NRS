# Some MARS system calls
# (c) 2016, GPL3
#
	.data
prompt:	.asciiz	"Please tell me how old you are: "
result:	.asciiz	"You told me that your age is "

	.text
main:
	li $v0, 4		# Izvrsi print_string
	la $a0, prompt	# koristeci promenjivu "prompt"
	syscall
					# Izvrsi read_int
	li $v0, 5		# i ucitaj broj u $v0
	syscall
	move $t0, $v0	# Bezbedno ga prekopiraj u $t0

	li $v0, 4		# Ispisi "result" string
	la $a0, result
	syscall
					# Premesti godine u $a0
	move $a0, $t0	# da bismo ih ispisali
	li $v0, 1		# koristeci print_int 
	syscall
					
	li $v0, 10		# Izlaz iz programa
	syscall
