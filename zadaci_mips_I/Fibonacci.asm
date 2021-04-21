# This program calculates the first few Fibonacci numbers.
# (c) 2010 Warren Toomey, GPL 3
#
	 .data
message: .asciiz "The Fibonacci numbers below 1 million are\n1\n1\n"
newline: .asciiz "\n"

	.text
main:	la $a0, message			# Print out the message using syscall 4
	li $v0, 4
	syscall

	li $t0, 1			# Set registers $t0 and $t1 to be the
	li $t1, 1			# previous two numbers
loop:   add $t2, $t0, $t1		# Add them into the $t2 register
	bgt $t2, 1000000, endloop	# Break out of the loop if > 1000000

	move $a0, $t2			# Move current number into $a0 so we can print it
	li $v0, 1			# Print integer in $a0 out using syscall 1
	syscall

	move $t0, $t1			# Shuffle the numbers down. $t0 = $t1
	move $t1, $t2			# and $t1= $t2.

	la $a0, newline			# Print a newline with syscall 4
	li $v0, 4
	syscall
	b loop				# and loop back to do it again
endloop:
	li $v0, 10			# Exit the program with syscall 10
	syscall
	
