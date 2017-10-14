.section .text
.global parity_asm
# Input Argument:
#   a0: The address of the input array
#   a1: The size of input array
parity_asm:	
	addi sp, sp, -32 
	sd ra, 24(sp)
	sd s2, 16(sp)
	sd s1, 8(sp)
	sd s0, 0(sp)

	mv s0, a0		# s0 = list
	mv s1, a1		# s1 = SIZE
	li s2, 0		# i = 0

loop:
	slt t0, s2, s1	# t0 = 0 if (s2 >= s1)
	beq t0, zero, exit1
	
	slli t0, s2, 3	# t0 = i * 8
	add t1, s0, t0	# t1 = list + t0
	ld  t2, 0(t1)	# t2 = list[i]

	andi t3, t2, 1	# D0
	srli t2, t2, 1
	andi t4, t2, 1	# D1
	srli t2, t2, 1
	andi t5, t2, 1 	# D2
	srli t2, t2, 1
	andi t6, t2, 1	# D3

# count
	add t3, t3, t4
	add t3, t3, t5
	add t3, t3, t6
	andi t3, t3, 1

	ld t2, 0(t1)
	slli t2, t2, 1
	add  t2, t2, t3
	
	sd t2, 0(t1)

	addi s2, s2, 1
	j loop

exit1:
	li a0, 0
	ld s0, 0(sp)
	ld s1, 8(sp)
	ld s2, 16(sp)
	ld ra, 24(sp)
	addi sp, sp, 32

	ret 
