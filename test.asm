.data
filename: .asciiz "test.txt"
output: .asciiz "output.txt"
buff: .space 1000
tempbuff:.space 1
.text
.globl  main
main:


#mo file
li $v0, 13
la $a0, filename
li $a1, 0
li $a2, 0
syscall

#Luu file descriptor vao a0
move $a0, $v0
la $s0, buff #Luu dia chi buff vao $s0
la $s1, tempbuff
li $t1, 0
#Doc file

	
ReadAllLines:
	jal ReadLine
	bne $v0, 0 , ReadAllLines #So sanh neu $t2 la ki tu ket thuc thi nhay sang out
	j out
#Thu tuc doc tung dong
ReadLine:
	li $v0, 14 #Syscall doc file
	la $a1, tempbuff
	li $a2, 1
	syscall
	addi $t1 $t1 1
	add $s2, $s2, $v0 #Thanh ghi s2 luu so ki tu doc duoc
	lb $t2, 0($s1) #Load 1 byte tu tempbuff vao $t2
	sb $t2, 0($s0) #Save $t2 vao $s7
	addi $s0, $s0, 1 #Tang vung nho buff len 1 don vi
	bne $t2, 10, ReadLine #So sanh neu ki tu vua doc la ki tu xuong dong thi dung
	jr $ra
	#Thanh ghi $v0 luc nay se ghi lai so ki tu doc duoc
	
#Mo file output
out:
	li $v0, 13
	la $a0, output
	li $a1, 1
	li $a2, 0
	syscall
	move $a0, $v0
#In chuoi da doc tu file vao file khac
	li $v0, 15
	la $a1, buff
	add $a2,$a2, $t1
	syscall
#Goi syscall ket thuc chuong trinh
li $v0,10
syscall
