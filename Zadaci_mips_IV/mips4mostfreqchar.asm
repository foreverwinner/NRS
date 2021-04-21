# storage of local variables on the stack.
# (c) 2016, GPL3

		.data
prompt:		.asciiz	"Please enter a line of text: "
resultstr:	.asciiz "The most frequent char you entered is "
resultchar:	.asciiz "X"

		.text
main:		
		li $v0, 4			# Ispis poruke
		la $a0, prompt
		syscall

		jal mostfreqchar	# Izracunamo najcesce korisceni karakter koji je unet

		sb $v0, resultchar	# Menjamo X u rezultatu sa nasim rezultatom

		li $v0, 4			# Ispis poruke o rezultatatu
		la $a0, resultstr
		syscall
		la $a0, resultchar	# i ispis tog karaktera
		syscall

		li $v0, 10			# Izlaz iz programa
		syscall

# Sledeca funkcija mostfreqchar() nema ulazne parametre.
# Ona iscitava liniju teksta u niz caraktera koji je smesten na steku
# I zatim obavlja sledeci algoritam da bi pronasla
# najcesce koriscen karakter u nizu
#
#  char mfc;	# char ce biti vracen kao rezultat
#  char ch;		# karakter koji trenutno brojimo
#  int cnt;		# Odbroj karaktera koji trenutno obradjujemo
#  int mfccnt=0;	# Odbroj mfc karaktera koji cemo vratiti
#
#  for (int iptr= pointer to line[0]; char at iptr != NUL; iptr++) {
#    ch= char at iptr;       	# Start counting this char
#    cnt=0;             		# No count for it yet
#    for (int jptr= pointer to line[0]; char at jptr != NUL; jptr++) {
#      if (char at jptr==ch) cnt++;  # Count it if we find it
#    }
#
#    if (cnt>mfccnt) { # Ovaj karakter ima najveci odbroj do sada
#      mfccnt= cnt;
#      mfc = ch;       # Zapisacemo ga kao najucestalijeg
#    }
#  }
#
#  return(mfc);
#
# Algoritam je neefikasan, ali zato koristi samo jednu lokalnu promenjivu,
# a to je ulazni string.
#
# Koriscenje registara i steka:
#				int iptr =>   $a0
#               int jptr =>   $a1
#               int cnt => $a2
#               int ch =>  $a3
#               int mfc => $v0, povratna vrednost
#			    int mfccnt => $v1
#			    char line[200] => 24($sp), length 200 bytes
#			    pointer to line[0] => $t1
#			    char at jptr => $t0
#
mostfreqchar:	subu $sp, $sp, 224	# Pravimo prosireni stek frejm
		sw $ra, 20($sp)

		li $v1, 0		# mfccnt = 0
		add $t1, $sp, 24	# Postavljamo $t da pokazuje na unetu liniju
		move $a0, $t1		# Postavljamo parametre za citanje stringa na read_string: ptr na uneti string
		li $v0, 8			# broj za read_int syscall
		li $a1, 200			# citamo do 200 karaktera
		syscall

		move $a0, $t1		# iptr = adresa od line[0]
iloop:		
		lb $a3, ($a0)		# ch = char setujemo na iptr
		beqz $a3, endiloop	# prekid petlje ako je ch NUL

			li $a2, 0		# cnt=0
			move $a1, $t1		# jptr = adresa od line[0]
jloop:			
			lb $t0, ($a1)		# jch = char pokazuje na jptr
			beqz $t0, endjloop	# prekid petlje ako je jch NUL
			bne $t0, $a3, jincr	# preskoci ako je ch != jch
			addi $a2, $a2, 1	# Pronasli smo poklapanje pa radimo cnt++
jincr:			
			addi $a1, $a1, 1	# jptr++
			b jloop				# povratak na jptr petlju

endjloop:	
		bgt $v1, $a2, iincr	# If mfccnt > cnt, preskoci
		move $v1, $a2		# else mfccnt = cnt
		move $v0, $a3		# takodje mfc = ch

iincr:		
		addi $a0, $a0, 1	# iptr++
		b iloop				# povratak na pocetak iptr petlje

endiloop:
endoffunc:	
		lw $ra, 20($sp)		# Ponovo ucitati povratnu adresu
		addu $sp, $sp, 224	# Unistavamo nas stek
		jr $ra				# povratak iz funkcije

