.section .data
# There are two global variables:
#  1. list: Store the numbers (4 bits) we want to add parity bit
#           The new number (4 + 1 bits) will replace the original number (4 bits).
#  2. SIZE: the size of the list
list: .dword NUM1, NUM2, NUM3, NUM4, NUM5 #Don't modify this line
SIZE: .dword 5
.section .text

.global main
main:
	mv    s7, ra
	la 	  a0, list
	ld	  a1, SIZE
	addi  s0, zero, 0 	# i = 0

for1tst:
	slt	  t0, s0, a1		# t0 = 0 if (i >= n)
	beq	  t0, zero, exit1 	# go to exit1 if (i >= n)
	jal   adpr				# jump to adpr (add parity)
	addi  s0, s0, 1			# i += 1
	j	  for1tst			# go back to loop for1tst

exit1:
	li    a0, 0
	mv    ra, s7
	ret	 #return, same as "jr ra" 

.global adpr
adpr:
	slli  t1, s0, 3			# t1 = i * 8
	add   t2, t1, a0		# t2 = t1 + a0 <list>
	lw	  s3, 0(t2)			# s3 = list[i] (low bits)
	lw	  s4, 4(t2)			# s4 = list[i] (high bits)
	mv    s5, t2
	
	mv    t5, s3			
	mv    t6, s4

	li    s1, 0				# j = 0
	li	  s2, 0				# counter = 0
for2est:					# count
	slti  t1, s1, 32
	beq   t1, zero, exit2
	
# low bits
	andi  t0, t5, 1
	beq   t0, zero, not_one1
	addi  s2, s2, 1			# counter++
not_one1:
# high bits
	andi  t0, t6, 1
	beq   t0, zero, not_one2
	addi  s2, s2, 1			# counter++
not_one2:
	srli   t5, t5, 1
	srli   t6, t6, 1

	addi  s1, s1, 1
	j     for2est

exit2:
	andi  t0, s2, 1			# if counter is odd
	beq	  t0, zero, add_zero
	
	slli   t0, s3, 1	
	slli   t1, s4, 1
	srli   t2, s3, 31
	addi  s3, t0, 1
	add   s4, t1, t2

add_zero:
	slli   t0, s3, 1
	slli   t1, s4, 1
	srli   t2, s3, 31
	addi  s3, t0, 0
	add   s4, t1, t2

	sw    s3, 0(s5)
	sw    s4, 4(s5)

	ret

