#include <asm.h>
#include <regdef.h>

#define TEST_CLO(in_a, res) \
    li a0, in_a; \
    li a1, res; \
    clo v0, a0; \
    bne a1, v0, inst_error; \
    nop

LEAF(clo_test)
    .set noreorder
    addiu s0, s0, 1
###test inst
    TEST_CLO(~0x00000000, 32)
    TEST_CLO(~0x00000001, 31)
    TEST_CLO(~0x00000002, 30)
    TEST_CLO(~0x00000004, 29)
    TEST_CLO(~0x00000008, 28)
    TEST_CLO(~0x00000010, 27)
    TEST_CLO(~0x00000020, 26)
    TEST_CLO(~0x00000040, 25)
    TEST_CLO(~0x00000080, 24)
    TEST_CLO(~0x00000100, 23)
    TEST_CLO(~0x00000200, 22)
    TEST_CLO(~0x00000400, 21)
    TEST_CLO(~0x00000800, 20)
    TEST_CLO(~0x00001000, 19)
    TEST_CLO(~0x00002000, 18)
    TEST_CLO(~0x00004000, 17)
    TEST_CLO(~0x00008000, 16)
    TEST_CLO(~0x00010000, 15)
    TEST_CLO(~0x00020000, 14)
    TEST_CLO(~0x00040000, 13)
    TEST_CLO(~0x00080000, 12)
    TEST_CLO(~0x00100000, 11)
    TEST_CLO(~0x00200000, 10)
    TEST_CLO(~0x00400000, 9)
    TEST_CLO(~0x00800000, 8)
    TEST_CLO(~0x01000000, 7)
    TEST_CLO(~0x02000000, 6)
    TEST_CLO(~0x04000000, 5)
    TEST_CLO(~0x08000000, 4)
    TEST_CLO(~0x10000000, 3)
    TEST_CLO(~0x20000000, 2)
    TEST_CLO(~0x40000000, 1)
    TEST_CLO(~0x80000000, 0)
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(clo_test)
