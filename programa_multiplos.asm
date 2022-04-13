.data
size:   .word 10
x:      .word 4
res:    .word 0
a:      .word 10,8,16,23,45,24,32,100,4,41
.text
main:
        lw $a0, 12($zero)       #la $a0, a
        lw $a1, 0($zero)     	#lw $a1,size
        lw $a2, 4($zero)	#lw $a2, x    
        jal count       	#0x0C000006
        sw $v0, 8($zero)	#sw $v0, res
        and $zero, $zero, $zero #nop
              
count: 
        and $s1, $zero,$zero
        and $t1, $zero,$zero
        j LF                    #0x08000013
LA:
        sll $s3, $t1, 2         #s3 = 4 * indice 
        add $s4, $a0, $s3       #base de a + 4 * indice
       	lw $t2, ($s4)           #lee a[i]	
        j modulo                #0x0800000e
resta: 
        sub $t2,$t2,$a2
modulo: slt $at, $t2, $a2
	beq $at, $zero, resta
        bne $t2,$zero,LB
        addi $s1,$s1,1 #incremento del acumulador
LB: 
	addi $t1,$t1,1
LF: 
	slt $at, $t1, $a1
	bne $at, $zero, LA        
        or $v0,$zero,$s1
        jr $ra