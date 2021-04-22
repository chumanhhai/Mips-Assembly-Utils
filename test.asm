.text
main:
	# init 
	li $s0, 7
	li $s1, 12
	
	
	# nor
	la $a0, norText
	jal printString
	
	la $a0, inputText
	add $a1, $zero, $s0
	jal printStringAndIntInBinary
	
	jal printNewLine
	
	la $a0, inputText
	add $a1, $zero, $s1
	jal printStringAndIntInBinary
	
	jal printNewLine
	
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	jal NOR
	
	move $a1, $v0
	la $a0, outputText
	jal printStringAndIntInBinary
	
	
	# mult4
	la $a0, mult4Text
	jal printString
	
	la $a0, inputText
	add $a1, $zero, $s0
	jal printStringAndInt
	jal printNewLine
	
	add $a0, $zero, $s0
	jal Mult4
	
	la $a0, outputText
	move $a1, $v0
	jal printStringAndInt
	
	
	# swap
	la $a0, swapText
	jal printString
	
	la $a0, inputText
	add $a1, $zero, $s0
	jal printStringAndInt
	jal printSpace
	add $a0, $zero, $s1
	jal printInt
	jal printNewLine
	
	la $a0, outputText
	jal printString
	
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	jal Swap
	
	jal printInt
	jal printSpace
	move $a0, $a1
	jal printInt
	
	
	# end program
	li $v0, 10
	syscall
	
.data
	inputText: .asciiz "inp: "
	outputText: .asciiz "out: "
	norText: .asciiz "\n\nNOR \n" 
	nandText: .asciiz "\n\nNAND \n" 
	notText: .asciiz "\n\nNOT \n"
	mult4Text: .asciiz "\n\nMult4\n"
	mul10Text: .asciiz "\n\nMult10\n"
	swapText: .asciiz "\n\nSwap \n"
	RightCircularShiftText: .asciiz "\n\nRightCircularShift \n" 
	LeftCircularShiftText: .asciiz "\n\nLeftCircularShift \n"
	toUpperText: .asciiz "\n\ntoUpper \n"
	toLowerText: .asciiz "\n\ntoLower \n"
	
.include "/home/hai/assembly/library/utils.asm"
	
