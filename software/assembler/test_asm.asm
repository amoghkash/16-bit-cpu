.data
counter:    .word 145
teSt:       .array 5 6 8
space:      .alloc 5


.text
ADDI r1, r0, 7


LabelTest:	addi	r1, r2, 0x6	           # TEST COMMENT
            add r2, r4,r6
            lw r2, r3 # test comment
    halt
    loadh test
    addi r3, r0, -4
    shift r1, r3
    lw    r3, r1
#adfss