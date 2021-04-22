# subprogram: printString
# author: Chu Manh Hai
# purpose: print string
# input: $a0 - address of the string
# output: none
.text
	printString:
		li $v0, 4
		syscall
		jr $ra
		
# subprogram: printNewLine
# author: Chu Manh Hai
# purpose: print new line
# input: none
# output: none
.text
	printNewLine:
		la $a0, _PNL_newLine
		li $v0, 4
		syscall
		jr $ra
.data
	_PNL_newLine: .asciiz "\n"

	
# subprogram: printSpace
# author: Chu Manh Hai
# purpose: print space
# input: none
# output: none
.text
	printSpace:
		la $a0, _PS_space
		li $v0, 4
		syscall
		jr $ra
.data
	_PS_space: .asciiz " "
						
# subprogram: printInt
# author: Chu Manh Hai
# purpose: print int
# input: $a0 - value of the integer
# output: none
.text
	printInt:
		li $v0, 1
		syscall
		jr $ra
		
# subprogram: printStringAndInt
# author: Chu Manh Hai
# purpose: print string and int
# input: $a0 - address of String 
#	 $a1 - value of the integer
# output: none
.text
	printStringAndInt:
		li $v0, 4
		syscall
		move $a0, $a1
		li $v0, 1
		syscall
		jr $ra
		
# subprogram: printStringAndIntInBinary
# author: Chu Manh Hai
# purpose: print string and int in form on binary
# input: $a0 - address of String 
#	 $a1 - value of the integer
# output: none
.text
	printStringAndIntInBinary:
		li $v0, 4
		syscall
		move $a0, $a1
		li $v0, 35
		syscall
		jr $ra
		
# subprogram: printIntInBinary
# author: Chu Manh Hai
# purpose: print an integer in form of binary
# input: $a0 - value of the integer
# output: none
.text
	printIntInBinary:
		li $v0, 35
		syscall
		jr $ra		

# subprogram: readInt
# author: Chu Manh Hai
# purpose: read input of type int
# input: none
# output: $v0 - value of the integer
.text
	readInt:
		li $v0, 5
		syscall
		jr $ra

# subprogram: readString
# author: Chu Manh Hai
# purpose: read input of type String
# input: $a0: address of string
#	 $a1: size of string
# output: none
.text
	readString:
		li $v0, 8
		syscall
		jr $ra

# subprogram: NOR
# author: Chu Manh Hai
# purpose: take 2 input and implement nor operation between them
# input: $a0, $a1: 2 input
# return: $v0 - value of $a0 nor $a1
.text
	NOR:
		nor $v0, $a0, $a1
		jr $ra
		
# subprogram: NAND
# author: Chu Manh Hai
# purpose: take 2 input and implement nand operation between them
# input: $a0, $a1: 2 input
# return: $v0 - value of $a0 nand $a1
.text
	NAND:
		and $v0, $a0, $a1
		not $v0, $v0
		jr $ra

# subprogram: NOT
# author: Chu Manh Hai
# purpose: take 1 input and return value of NOT
# input: $a0 - value
# output: $v0 - not value of input
.text
	NOT:
		not $v0, $a0
		jr $ra

# subprogram: Mult4
# author: Chu Manh Hai
# purpose: take 1 input and return value of 4*input using only sll
# input: $a0 - value
# output $v0 - value of $a0*4
.text
	Mult4:
		sll $v0, $a0, 2
		jr $ra

# subprogram: Mult10
# author: Chu Manh Hai
# purpose: take 1 input and return value of 10*input using only sll and add
# input: $a0 - value
# output $v0 - value of $a0*10
.text
	Mult10:
		sll $v0, $a0, 3
		add $v0, $v0, $a0
		add $v0, $v0, $a0
		jr $ra

# subprogram: Swap
# author: Chu Manh Hai
# purpose: take 2 input and swap value of them using only XOR
# input: $a0, $a1 - 2 value, $t9: temporary value
# output: none
.text
	Swap: 
		# $t9 <- $a0
		xor $t9, $t9, $t9
		xor $t9, $t9, $a0
		# $a0 <- $a1
		xor $a0, $a0, $a0
		xor $a0, $a0, $a1
		# $a1 <- $t9
		xor $a1, $a1, $a1
		xor $a1, $a1, $t9
		
		jr $ra

# subprogram: RightCircularShift
# author: Chu Manh Hai
# purpose: take 1 input and return 2 values. The first is the value that has been shifted 1 bit by right circular shifting,
# 	and the second is a bit that has been shifted
# input: $a0 - original value
# output: $v0 -  value that has been shifted 1 bit by right circular shifting,
# 	  $v1 -  a bit that has been shifted
.text
	RightCircularShift:
		and $v1, $a0, 1
		ror $v0, $a0, 1
		jr $ra

# subprogram: LeftCircularShift
# author: Chu Manh Hai
# purpose: take 1 input and return 2 values. The first is the value that has been shifted 1 bit by left circular shifting,
# 	and the second is a bit that has been shifted
# input: $a0 - original value
# output: $v0 -  value that has been shifted 1 bit by left circular shifting,
# 	  $v1 -  a bit that has been shifted
.text
	LeftCircularShift:
		ror $v0, $a0, 1
		and $v1, $v0, 1
		jr $ra
		
# subprogram; toUpper
# author: Chu Manh Hai
# purpose: take a string and its size and convert it to uppercase
# input: $a0 - address of the string
#	 $a1 - size
#	 $t8, $t9 - temporary values
# output: none
.text
	toUpper:
		li $t8, 0
		j toUpperLoop
	toUpperLoop:
		beq $t8, $a1, toUpperExit
		lb $t9, 0($a0)
		blt $t9, 'a', toUpperNext
		bgt $t9, 'z', toUpperNext
		subi $t9, $t9, 0x20
		sb $t9, 0($a0)
		addi $a0, $a0, 1
		j toUpperNext
	toUpperNext:
		addi $t8, $t8, 1
		j toUpperLoop
	toUpperExit:
		jr $ra
		
# subprogram; toLower
# author: Chu Manh Hai
# purpose: take a string and its size and convert it to lowercase
# input: $a0 - address of the string
#	 $a1 - size
#	 $t8, $t9 - temporary values
# output: none
.text
	toLower:
		li $t8, 0
		j toLowerLoop
	toLowerLoop:
		beq $t8, $a1, toLowerExit
		lb $t9, 0($a0)
		blt $t9, 'a', toLowerNext
		bgt $t9, 'z', toLowerNext
		subi $t9, $t9, 0x20
		sb $t9, 0($a0)
		addi $a0, $a0, 1
		j toUpperNext
	toLowerNext:
		addi $t8, $t8, 1
		j toLowerLoop
	toLowerExit:
		jr $ra

# subprogram: abs
# author: Chu Manh Hai
# purpose: take an absolute value of an integer
# input: $a0 - value
# ouput: $v0 - abs of input
.text
	abs:
		blt $a0, $zero, abs_if
		add $v0, $a0, $zero
		j abs_continue
	abs_if:
		sub $v0, $zero, $a0
		j abs_continue
	abs_continue:
		jr $ra
		
# subprogram: strcpy
# author: Chu Manh Hai
# purpose: copy string of src to des
# input: $a0 - address of des
#	$a1 - address of src
# 	$t9 - temporary register
# output: $v0 - address of null-character of des
.text
	strcpy:
		strcpy_loop:
			lb $t9, 0($a1)
			sb $t9, 0($a0)
			beq $t9, $zero, strcpy_end_loop
			addi $a0, $a0, 1
			addi $a1, $a1, 1
			j strcpy_loop
		strcpy_end_loop:
			add $v0, $a0, $zero
			jr $ra

# subprogram: concat
# author: Chu Manh Hai
# purpose: concat string of src1 and src2
# input: $a0 - address of src1
#	$a1 - address of src2
#	$a2 - address of des
#	$s6, $s7 - temporary values
# output: none
.text
	concat:
		# store $ra
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# copy $a0 to $a2
		add $s6, $a0, $zero
		add $s7, $a1, $zero
		
		add $a0, $a2, $zero
		add $a1, $s6, $zero
		jal strcpy
		
		# concat $a1 to $a2
		move $a0, $v0
		add $a1, $s7, $zero
		jal strcpy
		
		lw $ra, 0($sp)
		add $sp, $sp, 4
		jr $ra
		
# subprogram: exit_program
# author: Chu Manh Hai
# purpose: exit main program
# input: none
# output: none
.text
	exit_program:
		li $v0, 10
		syscall
	
# subprogram: get_string_length
# author: Chu Manh Hai
# purpose: get length of a string
# input: $a0 - address of the string
#	$t9 - temporary values
# output: $v0 - length
.text
	get_string_length:
		li $v0, 0
		get_string_length_loop:
			lb $t9, 0($a0)
			beq $t9, $zero, get_string_length_end_loop
			addi $v0, $v0, 1
			addi $a0, $a0, 1
			j get_string_length_loop
		get_string_length_end_loop:
			jr $ra
			
# subprogram: reverse_string
# author: Chu Manh Hai
# purpose: reverse a string and return new one
# input: $a0 - address of the string
#	$a1 - address of reversed string
#	$t7, %t8 - temporary values
# output: none
.text
	reverse_string:
		# store $ra
		addi $sp, $sp, -4
		sw $ra, 0($sp)		
		
		# get length of string
		jal get_string_length
		move $t7, $v0
		
		# move to the last character
		sub $a0, $a0, 1
		
		# reverse
		reverse_string_loop:
			beqz $t7, reverse_string_end_loop
			lb $t8, 0($a0)
			sb $t8, 0($a1)
			addi $a0, $a0, -1
			addi $a1, $a1, 1
			addi $t7, $t7, -1
			j reverse_string_loop
		reverse_string_end_loop:
			 # load $ra
			 lw $ra, 0($sp)
			 addi $sp, $sp, 4
			 jr $ra
		

		
		
	
		
		
		

