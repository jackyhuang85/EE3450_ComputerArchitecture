.section .text
.global search_3

################################################################################
# a0: base address of array A
# a1: number of elements in array A
# a2: target number
#
# Linear search.
# Optimize with:
# 1. loop unrolling
# 2. static reordering
################################################################################
search_3:
	mv	t0, zero			# t0 := i = 0
	loop:		
		lw 	t2, 0(a0)
		lw  t4, 4(a0)
		lw  t5, 8(a0)
		lw  t6, 12(a0)
		bne	t2, a2, loop2
		add t3, t0, 0
		mv	a0, t3
		ret
	loop2:	
		bne	t4, a2, loop3
		add t3, t0, 1
		mv	a0, t3
		ret
	loop3:
		bne	t5, a2, loop4
		add t3, t0, 2
		mv	a0, t3
		ret
	loop4:
		bne	t6, a2, cont 
		add t3, t0, 3
		mv	a0, t3
		ret
	cont:
		addi a0, a0, 16
		addi t0, t0, 4
		blt	t0, a1, loop
	
	li	a0, -1

	ret
