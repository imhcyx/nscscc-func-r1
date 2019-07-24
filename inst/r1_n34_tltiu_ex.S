#include <asm.h>
#include <regdef.h>

#define TEST_TLTIU_TRUE(in_a, in_b) \
    li  a0, in_a; \
    la    s4, 1f; \
1:  tltiu a0, in_b; \
    b inst_error; \
    nop; \
    bne s2, s7, inst_error; \
    nop

#define TEST_TLTIU_FALSE(in_a, in_b) \
    li  a0, in_a; \
    li  a1, in_b; \
    la    s4, 1f; \
1:  tltiu a0, in_b; \
    b 2f; \
    nop; \
    b inst_error; \
    nop; \
2:

LEAF(tltiu_ex_test)
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
    TEST_TLTIU_FALSE(0x00000000, 0x0000)
    TEST_TLTIU_FALSE(0x00000001, 0x0000)
    TEST_TLTIU_TRUE(0x00000000, 0x0001)
    TEST_TLTIU_TRUE(0x00007fff, 0x8000)
    TEST_TLTIU_FALSE(0xffff8000, 0x7fff)
    TEST_TLTIU_FALSE(0xffff8001, 0x8000)
    TEST_TLTIU_TRUE(0xffff8000, 0x8001)
    TEST_TLTIU_TRUE(0x00000000, 0xffff)
    TEST_TLTIU_FALSE(0xffffffff, 0x0000)
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(tltiu_ex_test)
