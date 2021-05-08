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
		# store $ra, $s6, $s7
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $s6, 4($sp)
		sw $s7, 8($sp)
		
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
		
		# load data
		lw $ra, 0($sp)
		lw $s6, 4($sp)
		lw $s7, 8($sp)
		add $sp, $sp, 12
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
			 
# subprogram: printIntArray
# author: Chu Manh Hai
# purpose: print int array
# input: $a0 - base address of array
# 	$a1 - size of array
# output: none
.text
printIntArray:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	# store base and size
	move $s0, $a0
	move $s1, $a1
	
	# print open blacket
	la $a0, printIntArray_blacket_open
	jal printString
	
	# loop
	li $s2, 0
	printIntArray_loop:
		beq $s2, $s1, printIntArray_end_loop
		sll $t0, $s2, 2
		add $t0, $t0, $s0
		
		# print element
		lw $a0, 0($t0)
		jal printInt
		
		# print saparator
		la $a0, printIntArray_comma
		jal printString
		
		addi $s2, $s2, 1
		j printIntArray_loop
	printIntArray_end_loop:
		# print close blacket
		la $a0, printIntArray_blacket_close
		jal printString
		# restore values
		lw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		addi $sp, $sp, 16
		jr $ra
.data
	printIntArray_comma: .asciiz ", "
	printIntArray_blacket_open: .asciiz "[" 
	printIntArray_blacket_close: .asciiz "]"
	
# subprogram: printIntArrayDes
# author: Chu Manh Hai
# purpose: print int array in descending order
# input: $a0 - base address of array
# 	$a1 - size of array
# output: none
.text
printIntArrayDes:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	# store last and size
	move $s0, $a0
	move $s1, $a1
	
	# print open blacket
	la $a0, printIntArrayDes_blacket_open
	jal printString
	
	# loop
	move $s2, $s1
	addi $s2, $s2, -1
	printIntArrayDes_loop:
		blt $s2, 0, printIntArrayDes_end_loop
		sll $t0, $s2, 2
		add $t0, $t0, $s0
		
		# print element
		lw $a0, 0($t0)
		jal printInt
		
		# print saparator
		la $a0, printIntArrayDes_comma
		jal printString
		
		addi $s2, $s2, -1
		j printIntArrayDes_loop
	printIntArrayDes_end_loop:
		# print close blacket
		la $a0, printIntArrayDes_blacket_close
		jal printString
		# restore values
		lw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		addi $sp, $sp, 16
		jr $ra
.data
	printIntArrayDes_comma: .asciiz ", "
	printIntArrayDes_blacket_open: .asciiz "[" 
	printIntArrayDes_blacket_close: .asciiz "]"
	
# subprogram: max
# author: Chu Manh Hai
# purpose: get max of 2 number
# input: $a0, $a1 - two numbers
# output: $v0 - max
.text
max:
	bgt $a0, $a1, max_greater
	addi $v0, $a1, 0
	jr $ra
	
	max_greater:
		addi $v0, $a0, 0
		jr $ra
		
# subprogram: swapInt
# author: Chu Manh Hai
# purpose: swap value of 2 int number
# input $a0 - address of first int
#	$a1 - address of second int
# output: none
.text
swapInt:
	lw $t0, 0($a0)
	lw $t1, 0($a1)
	
	sw $t1, 0($a0)
	sw $t0, 0($a1)
	
	jr $ra

		
# subprogram: bubbleSort
# author: Chu Manh Hai
# purpose: sort an int array by bubble sort algorithm
# input: $a0 - array base
#	$a1 - array size
# output: none
.text
bubbleSort:
	# store value
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	
	move $s0, $a0
	move $s1, $a1
	
	addi $s2, $s1, -2
	bubbleSort_outerLoop:
		blt $s2, 0, bubbleSort_outLoop_exit
		li $s3, 0
		bubbleSort_innerLoop:
			bgt $s3, $s2, bubbleSort_innerLoop_exit
			# get a[i]
			sll $t0, $s3, 2
			add $t0, $t0, $s0
			lw $t2, 0($t0)
			# get a[i+1]
			addi $t1, $s3, 1
			sll $t1, $t1, 2
			add $t1, $t1, $s0
			lw $t3, 0($t1)
			# if a[i] > a[i+1] swap
			bgt $t2, $t3, bubbleSort_swap
			j bubbleSort_innerLoop_continue
			bubbleSort_swap:
				move $a0, $t0
				move $a1, $t1
				jal swapInt
			bubbleSort_innerLoop_continue:
				addi $s3, $s3, 1
				j bubbleSort_innerLoop
		bubbleSort_innerLoop_exit:
			addi $s2, $s2, -1
			j bubbleSort_outerLoop
	bubbleSort_outLoop_exit:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		addi $sp, $sp, 20
		
		jr $ra
			
# subprogram: allocate_heap
# author: Chu Manh Hai
# purpose: allocate space in heap
# input: $a0 - size
# output: $v0 - address
.text
allocate_heap:
	li $v0, 9
	syscall
	
	jr $ra
	

# subprogram: selectionSort
# author: Chu Manh Hai
# purpose: sort an int array by selection sort algorithm
# input: $a0 - array base
#	$a1 - array size
# output: none
.text
selectionSort:
	# store data
	addi $sp, $sp, -32
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	
	move $s0, $a0
	move $s1, $a1
	li $s2, 0
	add $s3, $s1, -1
	
	selectionSort_outer_loop:
		beq $s2, $s3, selectionSort_outer_loop_exit
		# store address of a[i]
		sll $s6, $s2, 2
		add $s6, $s6, $s0
		
		move $s5, $s6 # address of min
		add $s4, $s2, 1
		selectionSort_inner_loop:
			beq $s4, $s1, selectionSort_inner_loop_exit
			# store address of a[j]
			sll $t1, $s4, 2
			add $t1, $t1, $s0
			
			lw $t2, 0($s5) # min
			lw $t3, 0($t1) # a[j]
			blt $t3, $t2, selectionSort_if_less # if a[j] < min
			j selectionSort_inner_loop_continue
			selectionSort_if_less:
				move $s5, $t1
			selectionSort_inner_loop_continue:
				addi $s4, $s4, 1
				j selectionSort_inner_loop
		selectionSort_inner_loop_exit:
			# swap a[i] and min
			move $a0, $s5
			move $a1, $s6
			jal swapInt
			addi $s2, $s2, 1
	selectionSort_outer_loop_exit:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s6, 28($sp)
		addi $sp, $sp, 32
		
		jr $ra
			 
# subprogram: is_prime
# author: Chu Manh Hai
# purpose: check if an int is a prime
# input: $a0 - an int
# output: $v0 - result: 0 means no, 1 means yes
.text
is_prime:
	 # store data
	 addi $sp, $sp, -8
	 sw $s0, 0($sp)
	 sw $s1, 4($sp)
	 
	 #
	 move $s0, $a0
	 li $s1, 2
	 is_prime_loop:
	 	li $v0, 1
	 	beq $s1, $s0, is_prime_loop_exit
	 	rem $t0, $s0, $s1
	 	beqz $t0, is_prime_if_divisible
	 	j is_prime_loop_continue
	 	is_prime_if_divisible:
	 		li $v0, 0
	 		j is_prime_loop_exit
	 	is_prime_loop_continue:
	 		addi $s1, $s1, 1
	 		j is_prime_loop
	 is_prime_loop_exit:
	 	lw $s0, 0($sp)
	 	lw $s1, 4($sp)
	 	addi $sp, $sp, 8
	 	
	 	jr $ra
	 	
# subprogram: binary_search
# author: Chu Manh Hai
# purpose: search for elment in int array
# input: $a0 - address of array
#	$a1 - start
#	$a2 - end
#	$a3 - an integer
# output: $v0 - index of integer (-1 means that an int does not exist)
#	$v1 - number of recursion to be called
.text
binary_search:
	# store value
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	# not found condition
	bgt $a1, $a2, binary_search_return_not_found
	
	# search
	add $s0, $a1, $a2
	div $s0, $s0, 2 # index of middle
	sll $s1, $s0, 2 
	add $s1, $s1, $a0
	lw $s1, 0($s1) # value of middle
	
	beq $s1, $a3, binary_search_if_equal # if middle = x
	bgt $s1, $a3, binary_search_if_greater # if middle > x
	j binary_search_if_less # if middle < x
	
	binary_search_if_equal:
		move $v0, $s0
		li $v1, 1
		j binary_search_return
	binary_search_if_greater:
		addi $s0, $s0, -1
		move $a2, $s0
		jal binary_search
		addi $v1, $v1, 1
		j binary_search_return
	binary_search_if_less:
		addi $s0, $s0, 1
		move $a1, $s0
		jal binary_search
		addi $v1, $v1, 1
		j binary_search_return
	binary_search_return_not_found:
		li $v0, -1
		li $v1, 1
		j binary_search_return
	binary_search_return:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		addi $sp, $sp, 12
		
		jr $ra
	
	
	
	
	 	
	

		
		
	
		
		
		

