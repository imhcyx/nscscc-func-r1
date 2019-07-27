#include <asm.h>
#include <regdef.h>

#define TEST_INST_EX_BEGIN(bev, exl, iv) \
    li t0, 0x0000ff01; \
    li t1, bev<<22; \
    or t0, t1; \
    li t1, exl<<1; \
    or t0, t1; \
    mtc0 t0, c0_status; \
    li t0, iv<<23; \
    mtc0 t0, c0_cause; \
    li s7, -1; \
    la s5, 2f

#define TEST_INST_EX_END(vec) \
2:  li t0, vec; \
    bne t0, s7, inst_error; \
    nop

LEAF(ex_vec_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, -1
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
    mtc0  s7, c0_status
    nop
    lui   s7, 0x0009      #trap ex, ref return value.
###test inst
    ##1
    TEST_INST_EX_BEGIN(0, 0, 0)
    li t0, 0x12345678
    lw t0, 0(t0) # refill
    TEST_INST_EX_END(0x80000000)
    ##2
    TEST_INST_EX_BEGIN(0, 1, 0)
    li t0, 0x12345678
    lw t0, 0(t0) # refill
    TEST_INST_EX_END(0x80000180)
    ##3
    TEST_INST_EX_BEGIN(1, 0, 0)
    li t0, 0x12345678
    lw t0, 0(t0) # refill
    TEST_INST_EX_END(0xbfc00200)
    ##4
    TEST_INST_EX_BEGIN(1, 1, 0)
    li t0, 0x12345678
    lw t0, 0(t0) # refill
    TEST_INST_EX_END(0xbfc00380)
    ##5
    TEST_INST_EX_BEGIN(0, 0, 0)
    mfc0 t0, c0_cause
    ori t0, 1<<8
    mtc0 t0, c0_cause # int
1:  b 1b
    nop
    TEST_INST_EX_END(0x80000180)
    ##6
    TEST_INST_EX_BEGIN(0, 0, 1)
    mfc0 t0, c0_cause
    ori t0, 1<<8
    mtc0 t0, c0_cause # int
1:  b 1b
    nop
    TEST_INST_EX_END(0x80000200)
    ##7
    TEST_INST_EX_BEGIN(1, 0, 0)
    mfc0 t0, c0_cause
    ori t0, 1<<8
    mtc0 t0, c0_cause # int
1:  b 1b
    nop
    TEST_INST_EX_END(0xbfc00380)
    ##8
    TEST_INST_EX_BEGIN(1, 0, 1)
    mfc0 t0, c0_cause
    ori t0, 1<<8
    mtc0 t0, c0_cause # int
1:  b 1b
    nop
    TEST_INST_EX_END(0xbfc00400)
    ##9
    TEST_INST_EX_BEGIN(0, 0, 0)
    syscall
    TEST_INST_EX_END(0x80000180)
    ##9
    TEST_INST_EX_BEGIN(1, 0, 0)
    syscall
    TEST_INST_EX_END(0xbfc00380)
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    li t0, 0x0040ff02
    mtc0 t0, c0_status
    mtc0 zero, c0_cause
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(ex_vec_test)
