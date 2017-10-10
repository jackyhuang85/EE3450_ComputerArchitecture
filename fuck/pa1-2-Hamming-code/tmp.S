.section .data
# There are two global variables:
#  1. list: Store the numbers ( 4 bits ) we want to encode with hamming codes
#           The encoded number ( 4 + 3 bits ) will replace the original number (4 bits).
#  2. SIZE: the size of the list
list: .dword 2, 1, 6, 4, 8 #Don't modify this line
SIZE: .dword 5
.section .text

.global main
main:
	mv s6, ra
	la a0, list
	ld a1, SIZE
	ld x5, 0(a0) 

loop:
	andi x6, x5, 1
	mv  t0, x6
	andi x6, x5, 2
	mv  t1, x6
	andi x6, x5, 3
	mv  t2, x6
	andi x6, x5, 4
	mv  t3, x6

	xor x7, t3, t1
	xor x7, x7, t0
	xor x8, t3, t2
	xor x9, x8, t1
	xor x8, x8, t0
	
	slli t3, t3, 6
	slli t2, t2, 5
	slli t1, t1, 4
	slli x9, x9, 3
	slli t0, t0, 2
	slli x8, x8, 1
	
	add t3, t3, t2
	add t3, t3, t1
	add t3, t3, x9
	add t3, t3, x8
	add t3, t3, x7
	add t3, t3, t0
	sd t3, 0(a0)

	addi a0, a0, 8
	addi a1, a1, -1
	bge a1, x0, loop
	mv  ra, s6
	ret           #return (jump to the addr store in register ra)
	

