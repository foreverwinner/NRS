# String manipulation with indexed addressing.
# (c) 2016, GPL3


# Imamo string, koji zelimo da konvertujemo tako da sva sloba budu mala.
# U MIPS-u, kao i u C jeziku, svi karakteri su velicine jednog bajt.
# Poslednji bajt je NUL terminator koji oznacava kraj stringa.

# Algoritam u pseudo-kodu je:
#	      Start at the base of the array, offset 0
#	loop: Fetch the character at this position
#	      If it's a NUL, break out of the loop
#	      If the value is between 'A' and 'Z' inclusive 
#		  {
#			OR with the value 32, which adds 32 to the value
#			Store the new value back into the array
#	      }
#	      Move up to the next character offset
#	      Branch back to the top of the loop
#       end:  ... code after the loop ...

	.data
string:	.asciiz	"Thos is a space were string be LOWERCASED is loaded!\n"

	.text
main:				# Prvo ispis starog stringa
	la $a0, string
	li $v0, 4
	syscall
	
	#ovde kodovati
	
	la $v0, 10		# Exit the program
	syscall
