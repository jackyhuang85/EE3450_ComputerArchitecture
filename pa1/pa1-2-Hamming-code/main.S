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

    ret            #return (jump to the addr store in register ra)
	
