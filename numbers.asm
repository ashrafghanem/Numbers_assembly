.data 
	arr:  .space 48        # 48 bytes = 12 integers
	space: .asciiz "   "   # .asciiz declares a null terminated string
	count_positive: .asciiz "\nThe count of 2-digit positive integers= "
	count_negative: .asciiz "\nThe count of 2-digit negative integers= "
	sum_odd: .asciiz "\nThe sum of all odd numbers= "
	product_even: .asciiz "\nThe product of all even numbers= "
	sortedArr: .asciiz "\nThe integer numbers [sorted in ascending order]: "
	decimalPoint: .asciiz "."
.text
	la $t1,arr
	li $t0, 0
	li $t5, 0
	li $s7, 0
	li $t7, 1
	li $t8, 0
	li $t6, 12
	li $t9, -10
	li $s1, -100
	li $s2, 10
	li $s3, 100

label1:
	mul $t3, $t0, 4
	addu $t4, $t3, $t1
	li $v0, 5
	syscall

	ble $v0, $t9, label2 # if less than or equal -10
	bge $v0, $s2, label3 # if greater than 10
	j label1
	
label2:
	bgt $v0, $s1, label4 # if greater than -100
	j label1
	
label3: 
	blt $v0, $s3, label5 # if less than 100
	j label1	
	
label4:
	addi, $s7, $s7,1     # count of negative integers
	j done
	
label5:
	addi $t5, $t5, 1 	 # count of positive integers

done:					 # store integers in array
	sw $v0, 0($t4)
	addi $t0, $t0,1
	blt $t0,$t6, label1
	
#######################################################

	# sort the array in ascending order
	la  $t1, arr     
	addi $t1, $t1, 48 
	
loop1:
	add $a2, $0, $0     
	la  $s3, arr  
    
loop2:
	lw  $a3, 0($s3) 
	lw  $t2, 4($s3)        
	slt $a1, $t2, $a3      
	beq $a1, $0, continue   # if less skip ,else swap
	addi $a2, $0, 1        
	sw  $t2, 0($s3)         
	sw  $a3, 4($s3)    

continue:
	addi $s3, $s3, 4           
	bne  $s3, $t1, loop2    
	bne  $a2, $0, loop1	

#######################################################

	# Find the sum of odd and product of even integers.
	li $t0, 0
	la $t1, arr
	
	label6:
	mul $t3, $t0, 4
	addu $t4, $t3, $t1
	lw $a0, 0($t4)
	li $t9, 2
	div $a0,$t9
	mfhi $t3
	beqz $t3,prod_evenInt
	j sum_oddInt
	
	prod_evenInt:
	mul $t7,$t7,$a0
	j next
	
	sum_oddInt:
	add $t8,$t8,$a0
	
	next:
	addi $t0, $t0,1
	blt $t0,12, label6
	
#######################################################	
 
	# print the count of negative integers
	addi $v0, $0, 4  
	la $a0, count_negative   
	syscall

	li $v0,1
	move $a0,$s7 
	syscall
##############################

	# print the count of positive integers
	addi $v0, $0, 4  
	la $a0, count_positive  
	syscall

	li $v0,1
	move $a0,$t5 
	syscall
##############################
	
	# print the product of even integers
	addi $v0, $0, 4
	la $a0, product_even
	syscall

	li $v0,1
	move $a0,$t7
	syscall
##############################

	# print the sum of odd integers
	addi $v0, $0, 4
	la $a0, sum_odd
	syscall

	li $v0,1
	move $a0,$t8
	syscall
##############################

	# print the sorted integer array
	addi $v0, $0, 4  
	la $a0, sortedArr  
	syscall
	
	li $t0, 0
	la $t1, arr
	
label7:
	mul $t3, $t0, 4
	addu $t4, $t3, $t1
	li $v0,1
	lw $a0, 0($t4)
	syscall
	
	addi $v0, $zero, 4  
	la $a0, space       
	syscall
	
	addi $t0, $t0,1
	blt $t0,12, label7
