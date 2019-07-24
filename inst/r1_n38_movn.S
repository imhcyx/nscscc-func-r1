#include <asm.h>
#include <regdef.h>

LEAF(movn_test)
    .set noreorder
    addiu s0, s0, 1
###test inst
    ##1
    li v0, 0
    li a0, 0x11111111
    li a1, 0
    movn v0, a0, a1
    bne v0, zero, inst_error
    nop
    ##2
    li v0, 0
    li a0, 0x22222222
    li a1, 1
    movn v0, a0, a1
    bne v0, a0, inst_error
    nop
    ##3
    li v0, 0
    li a0, 0x33333333
    li a1, 0
    movn v0, a0, a1
    nop
    nop
    nop
    nop
    nop
    bne v0, zero, inst_error
    nop
    ##4
    li v0, 0
    li a0, 0x44444444
    li a1, 1
    movn v0, a0, a1
    nop
    nop
    nop
    nop
    nop
    bne v0, a0, inst_error
    nop
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(movn_test)
