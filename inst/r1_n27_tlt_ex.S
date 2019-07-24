#include <asm.h>
#include <regdef.h>

#define TEST_TLT_TRUE(in_a, in_b) \
    li  a0, in_a; \
    li  a1, in_b; \
    la    s4, 1f; \
1:  tlt a0, a1; \
    b inst_error; \
    nop; \
    bne s2, s7, inst_error; \
    nop

#define TEST_TLT_FALSE(in_a, in_b) \
    li  a0, in_a; \
    li  a1, in_b; \
    la    s4, 1f; \
1:  tlt a0, a1; \
    b 2f; \
    nop; \
    b inst_error; \
    nop; \
2:

LEAF(tlt_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0x09
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
    lui   s7, 0x0009      #trap ex, ref return value.
###test inst
 ##1
    TEST_TLT_FALSE(0x00000000, 0x00000000)
    TEST_TLT_FALSE(0x00000001, 0x00000000)
    TEST_TLT_TRUE(0x00000000, 0x00000001)
    TEST_TLT_FALSE(0x7fffffff, 0x80000000)
    TEST_TLT_TRUE(0x80000000, 0x7fffffff)
    TEST_TLT_FALSE(0x80000001, 0x80000000)
    TEST_TLT_TRUE(0x80000000, 0x80000001)
    TEST_TLT_FALSE(0x00000000, 0xffffffff)
    TEST_TLT_TRUE(0xffffffff, 0x00000000)
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(tlt_ex_test)
