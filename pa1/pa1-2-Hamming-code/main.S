.section .data
# There are two global variables:
#  1. list: Store the numbers ( 4 bits ) we want to encode with hamming codes
#           The encoded number ( 4 + 3 bits ) will replace the original number (4 bits).
#  2. SIZE: the size of the list
list: .dword NUM1, NUM2, NUM3, NUM4, NUM5 #Don't modify this line
SIZE: .dword 5
.section .text

.global main
main:
	la  a0, list
	ld  a1, SIZE
	mv  s3, ra
	addi  s0, zero, 0		# i = 0
loop:
	slt t0, s0, a1	# t0 = 1 if (i >= SIZE)
	beq t0, zero, exit

	slli t0, s0, 3  # t0 = i * 8
	add  s1, t0, a0 # s1 = &list[i]
	ld   s2, 0(s1) 	# s2 = list[i]

# each bit of num --> {t3, t2, t1, t0}
	andi t0, s2, 1	
	srli t1, s2, 1
	andi t1, t1, 1
	srli t2, s2, 2
	andi t2, t2, 1
	srli t3, s2, 3
	andi t3, t3, 1

# parity
	# P1 : t4
	xor t4, t3, t1
	xor t4, t4, t0
	# P2 : t5
	xor t5, t3, t2
	xor t5, t5, t0
	# P3 : t6
	xor t6, t3, t2
	xor t6, t6, t1

# Inserrrrrrrrrt
	srli t1, s2, 1
	slli t1, t1, 1
	add  t1, t1, t6		# D4 D3 D2 P3

	slli t1, t1, 1
	add  t1, t1, t0		# D4 D3 D2 P3 D1

	slli t1, t1, 1
	add  t1, t1, t5		# D4 D3 D2 P3 D1 P2

	slli t1, t1, 1
	add  t1, t1, t4		# D4 D3 D2 P3 D1 P2 P1

# Storeeeeee it!!!! fuck it's 1:30am
	sd 	 t1, 0(s1)

	addi s0, s0, 1  # i += 1 
	j	loop

exit:	
    li  a0, 0
	mv  ra, s3
	ret            #return (jump to the addr store in register ra)
	
