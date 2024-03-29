#include <asm.h>
#include <regdef.h>
#include <cpu_cde.h>

#define TEST_BLEZL(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    li v0, back_flag; \
    blezl t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    li t0, in_a; \
    blezl t0, 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    li v1, front_flag; \
4000:; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

LEAF(blezl_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x0
###test inst
    TEST_BLEZL(0x95b9206f, 0x6ad0a0b8, 0x8f08db03, 0x6ad0a0b8, 0x8f08db03)
    TEST_BLEZL(0x2c09b044, 0xc7826200, 0x13ea2762, 0x00000000, 0x00000000)
    TEST_BLEZL(0x095b7ae8, 0xa07a4a41, 0x56ac95c0, 0x00000000, 0x00000000)
    TEST_BLEZL(0xce67bc51, 0x2f1cd2c0, 0x00ba8e99, 0x2f1cd2c0, 0x00ba8e99)
    TEST_BLEZL(0x2a69b9f8, 0x50fdd280, 0x81eb6d5e, 0x00000000, 0x00000000)
    TEST_BLEZL(0x4a89b5b0, 0xd9579e00, 0x59631c54, 0x00000000, 0x00000000)
    TEST_BLEZL(0xb65d8ec0, 0x8c562016, 0xe0277158, 0x8c562016, 0xe0277158)
    TEST_BLEZL(0x24873e20, 0x404b79a8, 0x074de3ca, 0x00000000, 0x00000000)
    TEST_BLEZL(0x68aa32f0, 0x83cceb23, 0xc3902420, 0x00000000, 0x00000000)
    TEST_BLEZL(0xe047d460, 0x3f180c13, 0x3bc38a98, 0x3f180c13, 0x3bc38a98)
    TEST_BLEZL(0x7e5eca9a, 0x4b4a15fc, 0xd3480b3e, 0x00000000, 0x00000000)
    TEST_BLEZL(0x7430a9bc, 0xbf057200, 0x2fdbbe72, 0x00000000, 0x00000000)
    TEST_BLEZL(0xf836bb94, 0x37c816b0, 0xb5123aa5, 0x37c816b0, 0xb5123aa5)
    TEST_BLEZL(0x6b6daebe, 0x294e60b0, 0x500df160, 0x00000000, 0x00000000)
    TEST_BLEZL(0x02745600, 0x0bc79c38, 0x623d501e, 0x00000000, 0x00000000)
    TEST_BLEZL(0x8d274934, 0x699a3b30, 0xecb8b910, 0x699a3b30, 0xecb8b910)
    TEST_BLEZL(0x4797d3c4, 0x82f6e288, 0x18549ab0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x4df2d5b0, 0x240dab00, 0xfc313800, 0x00000000, 0x00000000)
    TEST_BLEZL(0x57a52a38, 0x212027e4, 0xfa719eb0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x8e038139, 0x1bcc05b9, 0x72ae72b0, 0x1bcc05b9, 0x72ae72b0)
    TEST_BLEZL(0xbf9c8198, 0xe541fb00, 0x1b7126c8, 0xe541fb00, 0x1b7126c8)
    TEST_BLEZL(0x1249b078, 0x01b12380, 0x2f82a822, 0x00000000, 0x00000000)
    TEST_BLEZL(0xecce1f70, 0xf9cba288, 0xd13e2f00, 0xf9cba288, 0xd13e2f00)
    TEST_BLEZL(0x00c38455, 0xc8482c40, 0x525f8eeb, 0x00000000, 0x00000000)
    TEST_BLEZL(0x9b684c3e, 0x980856a0, 0xb7a96a50, 0x980856a0, 0xb7a96a50)
    TEST_BLEZL(0x6b7793d8, 0x234e3918, 0xffac4ebc, 0x00000000, 0x00000000)
    TEST_BLEZL(0xe6d3f752, 0x840eda46, 0xe0fddba0, 0x840eda46, 0xe0fddba0)
    TEST_BLEZL(0x3fc31ca0, 0x91ce91aa, 0xdc8bc8e8, 0x00000000, 0x00000000)
    TEST_BLEZL(0xfa9c7468, 0x50f61b8c, 0xc3de5780, 0x50f61b8c, 0xc3de5780)
    TEST_BLEZL(0x1b91e180, 0x59594bd0, 0xedfca8b8, 0x00000000, 0x00000000)
    TEST_BLEZL(0x41cdee76, 0x91573db4, 0x71cafa0d, 0x00000000, 0x00000000)
    TEST_BLEZL(0xeba5e8e0, 0x6f2e7f30, 0x8c9ab700, 0x6f2e7f30, 0x8c9ab700)
    TEST_BLEZL(0xd8217e04, 0x982199e2, 0xf3b1afed, 0x982199e2, 0xf3b1afed)
    TEST_BLEZL(0x585bf2ea, 0xa23cdf53, 0x83ea0f80, 0x00000000, 0x00000000)
    TEST_BLEZL(0x87b6f470, 0xd9b4357c, 0x9583d2d0, 0xd9b4357c, 0x9583d2d0)
    TEST_BLEZL(0x6d9f4500, 0x79e1ef50, 0xa77673c0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x83c1a418, 0xc3077338, 0xf790ea84, 0xc3077338, 0xf790ea84)
    TEST_BLEZL(0xb9adf050, 0xe2887e9a, 0xcd447a90, 0xe2887e9a, 0xcd447a90)
    TEST_BLEZL(0x73fd4d18, 0x218b4000, 0xa411db70, 0x00000000, 0x00000000)
    TEST_BLEZL(0x2b26a3d5, 0x75f65d40, 0x41ad3428, 0x00000000, 0x00000000)
    TEST_BLEZL(0x8fb1c111, 0x4fb0ded0, 0x45e63380, 0x4fb0ded0, 0x45e63380)
    TEST_BLEZL(0x64e334c0, 0xfd9cb0c0, 0xaf32dc00, 0x00000000, 0x00000000)
    TEST_BLEZL(0x9a27606f, 0xf3e2611c, 0xd5e247ef, 0xf3e2611c, 0xd5e247ef)
    TEST_BLEZL(0x67f641d0, 0x01a396fc, 0xb659e860, 0x00000000, 0x00000000)
    TEST_BLEZL(0x132b9e7a, 0xbeee1cd5, 0xe9fa6eed, 0x00000000, 0x00000000)
    TEST_BLEZL(0x1439b2f1, 0x10474470, 0xb23f4a58, 0x00000000, 0x00000000)
    TEST_BLEZL(0x86472668, 0x054c9768, 0x6b140a00, 0x054c9768, 0x6b140a00)
    TEST_BLEZL(0x3d59835a, 0x8f2adfc4, 0x7618c700, 0x00000000, 0x00000000)
    TEST_BLEZL(0xc289835c, 0xab9e2684, 0x03727b3a, 0xab9e2684, 0x03727b3a)
    TEST_BLEZL(0x63162733, 0xcf15a60a, 0x4e2cab60, 0x00000000, 0x00000000)
    TEST_BLEZL(0xe4e1b69c, 0x84fac8f4, 0xf317b3b8, 0x84fac8f4, 0xf317b3b8)
    TEST_BLEZL(0x114c5c60, 0x13efa0f8, 0x9b0695dc, 0x00000000, 0x00000000)
    TEST_BLEZL(0x87b019d8, 0x4d432770, 0xce14ef40, 0x4d432770, 0xce14ef40)
    TEST_BLEZL(0x65544740, 0x8c91b054, 0x3ad3df8e, 0x00000000, 0x00000000)
    TEST_BLEZL(0xf1ec411c, 0x5cc4f38c, 0x780aa740, 0x5cc4f38c, 0x780aa740)
    TEST_BLEZL(0xcbf5b318, 0xc0f62e1c, 0xddbf6d18, 0xc0f62e1c, 0xddbf6d18)
    TEST_BLEZL(0x5ba1e1e3, 0x17ed66a0, 0x96f14968, 0x00000000, 0x00000000)
    TEST_BLEZL(0x7028d5ee, 0x9f17b83c, 0xc7b0a700, 0x00000000, 0x00000000)
    TEST_BLEZL(0xba71b96e, 0x2d83cddc, 0x879b1b76, 0x2d83cddc, 0x879b1b76)
    TEST_BLEZL(0xe5f87908, 0xb0479198, 0x7455d8b5, 0xb0479198, 0x7455d8b5)
    TEST_BLEZL(0xf9938b1c, 0x3755f1b1, 0x713878d2, 0x3755f1b1, 0x713878d2)
    TEST_BLEZL(0xbed71b16, 0x51d0ada5, 0xedaaec18, 0x51d0ada5, 0xedaaec18)
    TEST_BLEZL(0x1e2a14d4, 0x4abdb63c, 0x2b8a1cee, 0x00000000, 0x00000000)
    TEST_BLEZL(0x50f92580, 0x1ff26132, 0x88fb7170, 0x00000000, 0x00000000)
    TEST_BLEZL(0x772d24f0, 0xde3c740c, 0xb9d01798, 0x00000000, 0x00000000)
    TEST_BLEZL(0x18bc2f30, 0x2eee5b14, 0xab5f9b60, 0x00000000, 0x00000000)
    TEST_BLEZL(0x3cc6c742, 0x43972480, 0x91b369d8, 0x00000000, 0x00000000)
    TEST_BLEZL(0xbd930ae0, 0x86a83afc, 0xce1a5b3c, 0x86a83afc, 0xce1a5b3c)
    TEST_BLEZL(0x13554e80, 0x8e3e2bde, 0x70e5cc74, 0x00000000, 0x00000000)
    TEST_BLEZL(0xaa2005c0, 0xf42a3336, 0xed4081fe, 0xf42a3336, 0xed4081fe)
    TEST_BLEZL(0x97e9c124, 0x4f05b73c, 0x32b55baa, 0x4f05b73c, 0x32b55baa)
    TEST_BLEZL(0x37a17580, 0xb9743552, 0x8331b3e4, 0x00000000, 0x00000000)
    TEST_BLEZL(0x8362c950, 0x7a60c600, 0x5f370104, 0x7a60c600, 0x5f370104)
    TEST_BLEZL(0x90856db8, 0xa3fa22e6, 0x6a27abc6, 0xa3fa22e6, 0x6a27abc6)
    TEST_BLEZL(0xbeafdd2a, 0x2b462220, 0xcc7f8e40, 0x2b462220, 0xcc7f8e40)
    TEST_BLEZL(0xe595a157, 0x79d383d4, 0x27cb1dfe, 0x79d383d4, 0x27cb1dfe)
    TEST_BLEZL(0x1a12957a, 0x2e26cbc8, 0xb4982052, 0x00000000, 0x00000000)
    TEST_BLEZL(0x51fe5cb0, 0x9be9a801, 0xc0893889, 0x00000000, 0x00000000)
    TEST_BLEZL(0xc89a3f80, 0x0e679c00, 0x87087ca8, 0x0e679c00, 0x87087ca8)
    TEST_BLEZL(0x9e998ff0, 0xde42e4dc, 0xffa08270, 0xde42e4dc, 0xffa08270)
    TEST_BLEZL(0x9be1f200, 0xc3e4cf24, 0x78d8a4f0, 0xc3e4cf24, 0x78d8a4f0)
    TEST_BLEZL(0x49a624a4, 0x3d1100a0, 0xfd4dfbaa, 0x00000000, 0x00000000)
    TEST_BLEZL(0x0d5b5fc4, 0x818277d7, 0x96d42172, 0x00000000, 0x00000000)
    TEST_BLEZL(0xfdcf4418, 0x2e6c244c, 0x9f5f1880, 0x2e6c244c, 0x9f5f1880)
    TEST_BLEZL(0xb7c09260, 0x952c1842, 0x8de5fb68, 0x952c1842, 0x8de5fb68)
    TEST_BLEZL(0x5c962200, 0xc824a130, 0x96d24278, 0x00000000, 0x00000000)
    TEST_BLEZL(0x15bb13a8, 0x4a108f7e, 0xc62ca571, 0x00000000, 0x00000000)
    TEST_BLEZL(0xc48272e0, 0xf11426c6, 0x51e6261e, 0xf11426c6, 0x51e6261e)
    TEST_BLEZL(0x0eafc4fc, 0x1d3e5368, 0x9e445690, 0x00000000, 0x00000000)
    TEST_BLEZL(0x77ced790, 0x8c34482a, 0xe1636980, 0x00000000, 0x00000000)
    TEST_BLEZL(0xfcb04740, 0x14285356, 0x315841de, 0x14285356, 0x315841de)
    TEST_BLEZL(0x5be215d5, 0x6d02a228, 0xac790995, 0x00000000, 0x00000000)
    TEST_BLEZL(0x9b7ec798, 0x1fb304a0, 0xbeb280f4, 0x1fb304a0, 0xbeb280f4)
    TEST_BLEZL(0x0563cc5c, 0x3d1da630, 0x76c595b2, 0x00000000, 0x00000000)
    TEST_BLEZL(0x4aeb2cb0, 0x93179354, 0xaf9ad73c, 0x00000000, 0x00000000)
    TEST_BLEZL(0x7cef4170, 0xb3e9d820, 0x786ddb38, 0x00000000, 0x00000000)
    TEST_BLEZL(0x1b8cc576, 0x34f980ac, 0xe04787c0, 0x00000000, 0x00000000)
    TEST_BLEZL(0xf0ad69c4, 0x24c76233, 0xa4c06ad8, 0x24c76233, 0xa4c06ad8)
    TEST_BLEZL(0x275b5e48, 0x696ef32e, 0x040b5bf5, 0x00000000, 0x00000000)
    TEST_BLEZL(0x75773b3f, 0x59c405e8, 0xab483c80, 0x00000000, 0x00000000)
    TEST_BLEZL(0xdabd6b80, 0x1e86071b, 0xd097d70c, 0x1e86071b, 0xd097d70c)
    TEST_BLEZL(0x5640c590, 0x664a8080, 0xe7730e6c, 0x00000000, 0x00000000)
    TEST_BLEZL(0x2fe05383, 0xb6e29ec0, 0x6d57065d, 0x00000000, 0x00000000)
    TEST_BLEZL(0x9a903470, 0xefd86630, 0x5b08ad7c, 0xefd86630, 0x5b08ad7c)
    TEST_BLEZL(0x808bb1b0, 0x0da11d60, 0xf6c27e00, 0x0da11d60, 0xf6c27e00)
    TEST_BLEZL(0x68f73642, 0xd4f88718, 0x43966450, 0x00000000, 0x00000000)
    TEST_BLEZL(0x07fd55aa, 0x31767808, 0x0a5da390, 0x00000000, 0x00000000)
    TEST_BLEZL(0x16bb8e40, 0xa7583a00, 0xb4b4b4b4, 0x00000000, 0x00000000)
    TEST_BLEZL(0x5a06e0f0, 0xb7532635, 0xae95fbf8, 0x00000000, 0x00000000)
    TEST_BLEZL(0xa77ff1d2, 0xc4e3df56, 0x2c32b8cc, 0xc4e3df56, 0x2c32b8cc)
    TEST_BLEZL(0x524f086e, 0xb8e17e80, 0x17c29a30, 0x00000000, 0x00000000)
    TEST_BLEZL(0xf11cb410, 0xcd69f000, 0xd551659c, 0xcd69f000, 0xd551659c)
    TEST_BLEZL(0xc3d15830, 0x5e83b720, 0xf6f87f00, 0x5e83b720, 0xf6f87f00)
    TEST_BLEZL(0x468e63a5, 0xcf936450, 0x3a6092ac, 0x00000000, 0x00000000)
    TEST_BLEZL(0xc9f4180f, 0xd3e30300, 0xc0cc5af0, 0xd3e30300, 0xc0cc5af0)
    TEST_BLEZL(0x8d7a0320, 0x8a18f159, 0x34952370, 0x8a18f159, 0x34952370)
    TEST_BLEZL(0x7b2e3980, 0x45cfce80, 0x827fa060, 0x00000000, 0x00000000)
    TEST_BLEZL(0xec927780, 0xfe7bcfc6, 0xe41fe171, 0xfe7bcfc6, 0xe41fe171)
    TEST_BLEZL(0xe1d4d41e, 0xa2afd67f, 0x5afa056c, 0xa2afd67f, 0x5afa056c)
    TEST_BLEZL(0xfdc95ce0, 0x35be98ae, 0x157dec7c, 0x35be98ae, 0x157dec7c)
    TEST_BLEZL(0x9483e85f, 0x89c44f40, 0x60637e46, 0x89c44f40, 0x60637e46)
    TEST_BLEZL(0xc0de4c64, 0x4f7c3640, 0xa2f470c8, 0x4f7c3640, 0xa2f470c8)
    TEST_BLEZL(0xa27a4d9c, 0x50d2757c, 0xb9285670, 0x50d2757c, 0xb9285670)
    TEST_BLEZL(0x1cef6038, 0xc2421be0, 0xbabb8e77, 0x00000000, 0x00000000)
    TEST_BLEZL(0x9be68840, 0x695cfda0, 0xa71bc078, 0x695cfda0, 0xa71bc078)
    TEST_BLEZL(0xccca3490, 0xf8b23c1a, 0xb9ac4d90, 0xf8b23c1a, 0xb9ac4d90)
    TEST_BLEZL(0xda313724, 0x71bf8368, 0x01548108, 0x71bf8368, 0x01548108)
    TEST_BLEZL(0x02621df8, 0xbdbeaa7c, 0x7b9d3200, 0x00000000, 0x00000000)
    TEST_BLEZL(0x01eb3db0, 0xb7fe9960, 0x1ce520fe, 0x00000000, 0x00000000)
    TEST_BLEZL(0x4b18d264, 0x88ae7dee, 0xf3acd260, 0x00000000, 0x00000000)
    TEST_BLEZL(0x143aae48, 0x41dc5a50, 0x828adbaa, 0x00000000, 0x00000000)
    TEST_BLEZL(0x366c3c2c, 0xf42712e6, 0x4b9aad60, 0x00000000, 0x00000000)
    TEST_BLEZL(0xe7711093, 0x056b4fe2, 0x49f5abe6, 0x056b4fe2, 0x49f5abe6)
    TEST_BLEZL(0x138bc958, 0x23240c39, 0x7944bbb0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x4b6e2452, 0xc40b105f, 0xaeb927cc, 0x00000000, 0x00000000)
    TEST_BLEZL(0xe77dd0e0, 0xd55ef4f0, 0x3effd5dd, 0xd55ef4f0, 0x3effd5dd)
    TEST_BLEZL(0xd51d0a50, 0x2d2fade4, 0x0d721da1, 0x2d2fade4, 0x0d721da1)
    TEST_BLEZL(0x520e6cdd, 0xf931b650, 0xcd9cdb8a, 0x00000000, 0x00000000)
    TEST_BLEZL(0xa0c7dbb0, 0x1062e6de, 0xf0a48a34, 0x1062e6de, 0xf0a48a34)
    TEST_BLEZL(0xae6beae0, 0x38456eec, 0x472db7c1, 0x38456eec, 0x472db7c1)
    TEST_BLEZL(0x2ef88884, 0xd4e1944a, 0x5174eba4, 0x00000000, 0x00000000)
    TEST_BLEZL(0x2a1defe0, 0x96d0634c, 0xa2f2be02, 0x00000000, 0x00000000)
    TEST_BLEZL(0xa9bbb9e0, 0x71b3c7cc, 0x89f348b8, 0x71b3c7cc, 0x89f348b8)
    TEST_BLEZL(0xa8549800, 0xcd6520c8, 0xb1ceff00, 0xcd6520c8, 0xb1ceff00)
    TEST_BLEZL(0xb80d8e28, 0x223e2ce3, 0xcb32ecfc, 0x223e2ce3, 0xcb32ecfc)
    TEST_BLEZL(0x8635f602, 0x72fa6330, 0x25d2801a, 0x72fa6330, 0x25d2801a)
    TEST_BLEZL(0xa090c24a, 0x2de6fb00, 0xc14a318a, 0x2de6fb00, 0xc14a318a)
    TEST_BLEZL(0xbc557042, 0x0774f390, 0x73c64745, 0x0774f390, 0x73c64745)
    TEST_BLEZL(0xdae28800, 0x8a3b6daa, 0xf3136500, 0x8a3b6daa, 0xf3136500)
    TEST_BLEZL(0x24a62776, 0xa02c26b6, 0xfdf62090, 0x00000000, 0x00000000)
    TEST_BLEZL(0x36925ac4, 0xed7714b0, 0x6629ee00, 0x00000000, 0x00000000)
    TEST_BLEZL(0x67abbfc0, 0x71bbded0, 0x3fee6160, 0x00000000, 0x00000000)
    TEST_BLEZL(0x64bb0041, 0x3d8f1a8a, 0x044192d0, 0x00000000, 0x00000000)
    TEST_BLEZL(0xef5e36ec, 0x6fb68600, 0xde3be459, 0x6fb68600, 0xde3be459)
    TEST_BLEZL(0x58617c0c, 0x1e475e98, 0xd25d3c80, 0x00000000, 0x00000000)
    TEST_BLEZL(0x4f5aa540, 0xfed4acc0, 0x94e290c0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x15c8a6a4, 0xd41b1e8e, 0x107ec850, 0x00000000, 0x00000000)
    TEST_BLEZL(0x84aeb3d1, 0x180fc230, 0x0f6b277c, 0x180fc230, 0x0f6b277c)
    TEST_BLEZL(0x75f1e8ec, 0xd46dc404, 0x8a0c2f80, 0x00000000, 0x00000000)
    TEST_BLEZL(0xa71df424, 0x9dbd96ba, 0xc34f1395, 0x9dbd96ba, 0xc34f1395)
    TEST_BLEZL(0x6a497260, 0x6ca51928, 0x49631ed4, 0x00000000, 0x00000000)
    TEST_BLEZL(0xde465880, 0x03eea8a0, 0x75a88f70, 0x03eea8a0, 0x75a88f70)
    TEST_BLEZL(0x62b84868, 0x0710f698, 0x5d488830, 0x00000000, 0x00000000)
    TEST_BLEZL(0x6f0b5010, 0x6736cbdc, 0xb4104e66, 0x00000000, 0x00000000)
    TEST_BLEZL(0x6268d97e, 0x7cd6e57c, 0x0372e4e8, 0x00000000, 0x00000000)
    TEST_BLEZL(0xbdf615ac, 0xd7418070, 0x22ddbf82, 0xd7418070, 0x22ddbf82)
    TEST_BLEZL(0x5f8e9c47, 0xdced0c38, 0x58188fe0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x200a1580, 0x3f599ee0, 0xc9a416ac, 0x00000000, 0x00000000)
    TEST_BLEZL(0xc483b8a4, 0xcfa4be8b, 0x5fb8c0f6, 0xcfa4be8b, 0x5fb8c0f6)
    TEST_BLEZL(0xcd793200, 0x5deb5e4c, 0x512f3cea, 0x5deb5e4c, 0x512f3cea)
    TEST_BLEZL(0x3308ef00, 0x62035890, 0x9722fa12, 0x00000000, 0x00000000)
    TEST_BLEZL(0x5938314e, 0xc02ede0d, 0x9bbef21a, 0x00000000, 0x00000000)
    TEST_BLEZL(0x58dc9f26, 0x4a6e0b42, 0x6c5cdeb0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x2bbb8200, 0xafa5358e, 0xb5c94626, 0x00000000, 0x00000000)
    TEST_BLEZL(0xc04e53a0, 0x5caf581c, 0xe20e8a18, 0x5caf581c, 0xe20e8a18)
    TEST_BLEZL(0xc5a291b6, 0xbee2a7c6, 0xee1d4d60, 0xbee2a7c6, 0xee1d4d60)
    TEST_BLEZL(0xb01ab8d0, 0x5a1265a6, 0x07914eb2, 0x5a1265a6, 0x07914eb2)
    TEST_BLEZL(0x9d160dfc, 0x6810e584, 0x1a4ad589, 0x6810e584, 0x1a4ad589)
    TEST_BLEZL(0x1f0ba8e4, 0x10d11628, 0x38753511, 0x00000000, 0x00000000)
    TEST_BLEZL(0x6507ec40, 0xea5f9140, 0x17f21988, 0x00000000, 0x00000000)
    TEST_BLEZL(0x1868a42b, 0xa932da00, 0x1f466b40, 0x00000000, 0x00000000)
    TEST_BLEZL(0xb8578598, 0x3830c310, 0x9a1949a8, 0x3830c310, 0x9a1949a8)
    TEST_BLEZL(0x3dbf9e34, 0xf1ce7584, 0xb008118b, 0x00000000, 0x00000000)
    TEST_BLEZL(0x0fe66641, 0xb8e006b2, 0x7fc52652, 0x00000000, 0x00000000)
    TEST_BLEZL(0x306dc10e, 0xcd12d338, 0xbba7d90c, 0x00000000, 0x00000000)
    TEST_BLEZL(0x540dc4a4, 0xeec36fc0, 0x7405fca0, 0x00000000, 0x00000000)
    TEST_BLEZL(0xa4370260, 0xcfe8ef46, 0x4ca61163, 0xcfe8ef46, 0x4ca61163)
    TEST_BLEZL(0x5e23d148, 0x10970080, 0x24e4393d, 0x00000000, 0x00000000)
    TEST_BLEZL(0xe886dcfa, 0xf7efa088, 0xfff814d0, 0xf7efa088, 0xfff814d0)
    TEST_BLEZL(0x0e73e9d5, 0x09e3f920, 0x19f227c0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x75eb13ea, 0xb4b78c80, 0xea258bd0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x19015b8e, 0x4e1940fc, 0x38e20270, 0x00000000, 0x00000000)
    TEST_BLEZL(0x972de888, 0x4aafc444, 0xa570efa8, 0x4aafc444, 0xa570efa8)
    TEST_BLEZL(0xee1a2edc, 0xf0d7500c, 0x1757a2b8, 0xf0d7500c, 0x1757a2b8)
    TEST_BLEZL(0x443c7e4e, 0x3e943321, 0xf4a152a0, 0x00000000, 0x00000000)
    TEST_BLEZL(0x117e8344, 0xbabf26a8, 0x9c06c0c0, 0x00000000, 0x00000000)
    TEST_BLEZL(0xdab562ac, 0xea867f00, 0x6d7650e5, 0xea867f00, 0x6d7650e5)
    TEST_BLEZL(0x8d7e9274, 0xd0522db0, 0xd10a197c, 0xd0522db0, 0xd10a197c)
    TEST_BLEZL(0xdcfafe3c, 0x2a46001d, 0x05fa2efa, 0x2a46001d, 0x05fa2efa)
    TEST_BLEZL(0xf2938d4c, 0x207bd558, 0xaacfecf0, 0x207bd558, 0xaacfecf0)
    TEST_BLEZL(0x00000000, 0xbb9734a0, 0xff0af084, 0xbb9734a0, 0xff0af084)
###detect exception
    bne s2, zero, inst_error
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
END(blezl_test)
