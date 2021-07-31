.data

	Array: .word 0 0 0 0 0 3 2 4 8 6 5
	
.text
la $a0, Array
addi $a1, $zero, 11 #tamanho. Mudando para tamanho + 5 = 11
jal ordena 
lw $t8, 24($a0)
li $v0,10
syscall

ordena:
addi $t0,$zero, 6 # i=1. Mudando para i + 5 = 6
loop1:
beq $t0,$a1,fim

#mantendo o valor de a[i]

sll $t4, $t0, 2 #t4 = i*4
add $t4,$t4,$a0
lw $t4,0($t4) #valor = $t4 = a[i]

#for
addi $t1,$t0, -1
loop2:
slt  $t2,$t1,$zero #t2 = 1 if j < 0
bne $t2,$zero,foraLoop

#a[j] > valor
sll $t3,$t1,2
add $t3,$t3,$a0
lw $t3,0($t3)
slt $t5,$t3,$t4 # t5 = 1 if t3 < valor
bne $t5,$zero,foraLoop

#a[j+1} = a[j]
addi $t6,$t1,1
sll $t6,$t6,2
add $t6,$t6,$a0
sw $t3,0($t6)
addi $t1,$t1,-1
j loop2


foraLoop:
# a[j+1] = value

addi $t8,$t1,1
sll  $t8,$t8,2
add $t8,$t8,$a0
sw  $t4, 0($t8)
addi $t0,$t0,1
j loop1

fim:
jr $ra
