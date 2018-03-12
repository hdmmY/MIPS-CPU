

.text
addi $s0,$zero,1 
sll $s3, $s0, 31     
sra $s3, $s3, 31       
addu $s0,$zero,$zero         
addi $s2,$zero,12 

addiu $s6,$0,3 
zmd_loop:

addiu $s0, $s0, 1   
andi $s0, $s0, 15
subu $s0,$s0,$zero  #subu≤‚ ‘
xori $v0,$v0,0  #xori≤‚ ‘
sw $s0,0x0004($zero)
lb $a0,0x0004($zero)  #lb≤‚ ‘
bgez $s0, ceshi  #bgez≤‚ ‘
ceshi:
#######################################
addi $t0,$0,8    
addi $t1,$0,1
left:

sll $s3, $s3, 4   
or $s3, $s3, $s0

add    $a0,$0,$s3       
addi   $v0,$0,34         
syscall                

sub $t0,$t0,$t1
bne $t0,$0,left
#######################################

addi $s0, $s0, 1  
addi $t8,$0,15
and $s0, $s0, $t8
sll $s0, $s0, 28     

addi $t0,$0,8
addi $t1,$0,1

zmd_right:

srl $s3, $s3, 4  
or $s3, $s3, $s0

addu    $a0,$0,$s3       
addi   $v0,$0,34         
syscall                 

sub $t0,$t0,$t1
bne $t0,$0,zmd_right
srl $s0, $s0, 28  
#######################################

sub $s6,$s6,$t1
beq $s6,$0, exit     
j zmd_loop

exit:

add $t0,$0,$0
nor $t0,$t0,$t0     
sll $t0,$t0,16
ori $t0,$t0,0xffff

addu   $a0,$0,$t0       
addi   $v0,$0,34         
syscall                

addi   $v0,$zero,10        
syscall                  

