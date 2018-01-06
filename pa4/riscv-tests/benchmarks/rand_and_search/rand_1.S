.section .text
.global rand_1

################################################################################
# a0: base address of array A
# a1: number of elements in array A
# a2: seed
#
# Generate pseudo-random numbers.
################################################################################
rand_1:
	addi	sp, sp, -4
	sw		ra, 0(sp)

	sw		a2, 0(a0)		# a[0] = seed
	addi 	t1, zero, 1

	loop:
		addi	t2, t1, -1
		slli	t2, t2, 2
		add		t2, a0, t2
		lw		t2, 0(t2)	# tmp = a[i-1]
		
		##############################################################
		# tmp = (tmp ^ (tmp << 1) ^ (tmp << 6) ^ (tmp << 7)) & 0x80; #
		##############################################################
		slli	t3, t2, 1
		slli	t4, t2, 6
		slli	t5, t2, 7
		xor		t2, t2, t3
		xor		t2, t2, t4
		xor		t2, t2, t5
		andi	t2, t2, 0x80	# t2 := tmp

		##############################################################
		# a[i] = (a[i - 1] >> 1) | tmp;                              #
		##############################################################
		addi	t3, t1, -1
		slli	t3, t3, 2
		add		t3, t3, a0
		lw		t3, 0(t3)

		srli	t3, t3, 1
		or		t2, t2, t3

		slli	t3, t1, 2
		add 	t3, t3, a0
		sw		t2, 0(t3)



		addi 	t1, t1, 1
		blt		t1, a1, loop

	lw	ra, 0(sp)
	addi sp, sp, 4

	ret
