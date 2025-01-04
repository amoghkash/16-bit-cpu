.data
counter:    .word 0
teSt:       .array 5 6 7
space:      .alloc 1044


.text
ADDI r1, r0, 14


LabelTest:	addi	r1, r2,counter	           # TEST COMMENT
            add r2, r4,r6
            lw r2, Space # test comment

#adfss