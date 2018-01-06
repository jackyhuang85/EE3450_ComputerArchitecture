.section .text
.global search_1

################################################################################
# a0: base address of array A
# a1: number of elements in array A
# a2: target number
#
# Linear search.
################################################################################
search_1:
	mv	t0, zero			# t0 := i = 0
	loop:		
		lw 	t2, 0(a0)
		bne	t2, a2, cont 
		mv	a0, t0
		ret
		
	cont:
		addi a0, a0, 4
		addi t0, t0, 1
		bne	t0, a1, loop
	
	li	a0, -1
	ret
