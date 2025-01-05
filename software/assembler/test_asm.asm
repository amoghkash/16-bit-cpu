.data
counter:    .word 314
teSt:       .array 5 6 7
space:      .alloc 1044


.text
ADDI r1, r0, 7


LabelTest:	addi	r1, r2, 0x6	           # TEST COMMENT
            add r2, r4,r6
            lw r2, r3 # test comment
    halt
    loadh 0x495
#adfss