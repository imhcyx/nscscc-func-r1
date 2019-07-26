#include <asm.h>
#include <regdef.h>

#define TEST_SOFT_INT_EX(cause_init) \
    li   a3, 0x0040ff01; \
    li   v0, 0xffffffff; \
    li   v1, cause_init; \
    mtc0 zero, c0_count; \
    mtc0 v0, c0_compare; \
    mtc0 a3, c0_status; \
    nop; \
    la s4, 1f; \
    mtc0 v1, c0_cause; \
    1: b 1b; \
    nop

LEAF(ll_sc_test)
    .set noreorder
    addiu s0, s0, 1
###test inst
    li t0, 0x800d0000
    li a0, 0x08
    sw a0, 0(t0)
    ll a0, 0(t0)
    TEST_SOFT_INT_EX(0x00000100)
    sc a0, 0(t0)
    bnez a0, inst_error
    nop
    li   a3, 0x0040ff00
    mtc0 a3, c0_status
    li t0, 0x800d0000
    li a1, 0x55aa55aa
1:  ll a0, 0(t0)
    move a0, a1
    sc a0, 0(t0)
    beqz a0, 1b
    nop
    li a1, 1
    bne a0, a1, inst_error
    nop
    li t0, 0x800d0000
    lw a1, 0(t0)
    li a0, 0x55aa55aa
    bne a0, a1, inst_error
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
END(ll_sc_test)
