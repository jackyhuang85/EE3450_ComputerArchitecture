.section .text
.global rand_3

################################################################################
# a0: base address of array A
# a1: number of elements in array A
# a2: seed
#
# Generate pseudo-random numbers.
# Optimize with:
# 1. new instruction: lfsr
# 2. loop unrolling
################################################################################
rand_3:
	addi	sp, sp, -8
	sw		ra, 0(sp)
	sw		s1, 4(sp)
	
	li		s1, 0x380000c3

	sw		a2, 0(a0)		# a[0] = seed
	addi 	t1, zero, 1

	loop:
		slli	t2, t1, 2
		add		t2, t2, a0

		lw		t4, -4(t2)
		.word	0x9efe0b
		sw		t3, 0(t2)
		
		lw		t4, 0(t2)
		.word	0x9efe0b
		sw		t3, 4(t2)

		lw		t4, 4(t2)
		.word	0x9efe0b
		sw		t3, 8(t2)
		
		lw		t4, 8(t2)
		.word	0x9efe0b
		sw		t3, 12(t2)

		addi 	t1, t1, 4
		blt		t1, a1, loop

	lw	ra, 0(sp)
	lw  s1, 4(sp)
	addi sp, sp, 8

	ret
