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
	mv  s6, ra
	
	la  a0, list	# a0 = &list
	ld  a1, SIZE	# a1 = N
	li  s0, 0		# i = 0 

forloop:
	slt t0, s0, a1	# t0 = 0 (if i >= N)
	beq t0, zero, exit1
	
	slli t0, s0, 3	# t0 = i * 8
	add  s1, a0, t0 # s1 = &list + (i * 8)
	ld   s2, 0(s1)	# s2 = list[i]

# get each bit of num  
# NUM = {D3, D2, D1, D0}
	andi t0, s2, 1  # D0
	srli t1, s2, 1
	andi t1, t1, 1  # D1
	srli t2, s2, 2
	andi t2, t2, 1	# D2
	srli t3, s2, 3
	andi t3, t3, 1  # D3
	
# count/determine an odd or even number of 1
	add  t0, t0, t1
	add  t0, t0, t2
	add  t0, t0, t3
	andi t0, t0, 1
	
	slli s2, s2, 1
	add  s2, s2, t0

	sd   s2, 0(s1)

	addi s0, s0, 1
	j forloop

exit1:
	li 	a0, 0
	mv  ra, s6
	ret

