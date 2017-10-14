.section .text
.global hamming_asm
# Input Argument:
#   a0: The address of the input array
#   a1: The size of input array
hamming_asm:	
	addi sp, sp, -32
	sd ra, 24(sp)
	sd s0, 16(sp)
	sd s1, 8(sp)
	sd s2, 0(sp)
	
	li s0, 0 	# i = 0
loop:
	slt t0, s0, a1 		# t0 = 0 if (i >= SIZE)
	beq t0, zero, exit

	slli t0, s0, 3		# i * 8
	add s1, a0, t0		# s1 = list + (i * 8)
	ld  s2, 0(s1)		# s2 = list[i]
	
# each bit of num --> {t3, t2, t1, t0}
	andi t0, s2, 1
	srli t1, s2, 1
	andi t1, t1, 1
	srli t2, s2, 2
	andi t2, t2, 1
	srli t3, s2, 3
	andi t3, t3, 1

# Parity:
#---------------------------
# P1 = t3 + t1 + t0
# P2 = t3 + t2 + t0
# P3 = t3 + t2 + t1
#---------------------------
# P1 : t4
	xor t4, t3, t1
	xor t4, t4, t0
# P2 : t5
	xor t5, t3, t2
	xor t5, t5, t0
# P3 : t6
	xor t6, t3, t2
	xor t6, t6, t1

# Insert
	srli t1, s2, 1
	slli t1, t1, 1
	add  t1, t1, t6		# D4 D3 D2 P3

	slli t1, t1, 1
	add  t1, t1, t0		# D4 D3 D2 P3 D1

	slli t1, t1, 1
	add  t1, t1, t5		# D4 D3 D2 P3 D1 P2

	slli t1, t1, 1
	add  t1, t1, t4		# D4 D3 D2 P3 D1 P2 P1

# Store it  			# I hope it won't rain...
	sd   t1, 0(s1)

	addi s0, s0, 1
	j loop

exit:
	li a0, 0

	ld s2, 0(sp)
	ld s1, 8(sp)
	ld s0, 16(sp)
	ld ra, 24(sp)
	addi sp, sp, 32

	ret
