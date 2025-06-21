
// LPC11U35
.section .text
.syntax unified
.cpu cortex-m0
.thumb
.thumb_func
.align 2

.equ RCC_AHB1ENR, 0x40048080  // p28 SYSAHBCLKCTRL, address 0x4004 8080
.equ GPIOD_BASE, 0x50002000  // p
.equ GPIOD_MODER, 0x04      // p148 DIRP1 0x5000 2004
.equ PORT1, 0x50002104      // p149  PORT1 0x5000 2104

.equ PORT0, 0x50002100 //p149
.equ PORT0_BASE,0x50002000
.equ DIRP0,0x0 //p148
.equ PIO0_7,0x4004401C //p78
.equ PIO0_20,0x40044050
.equ PIO0_21,0x40044054
//R PIO0_20
//G PIO0_21



.global _start
.type _start, %function

//start 0x00000000
    .word   0x10001000 //p16
    .word   _start
    .word   _start
    .word   _start
    //0x10
    .word   _start
    .word   _start
    .word   _start
    //checksum VT０～７各数値を足して2の補数を出す。bin(2d020000)だったら0x22dで計算する。
    .word   0xefffe3fa
    //0x20
    .word   0
    .word   0
    .word   0
    .word   _start
    //0x30
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0x40
    .word   _start
    .word   _start
    .word   _start
    .word   _start
    //0x50
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0x60
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0x70
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0x80
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0x90
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0xA0
    .word   _start
    .word   _start
    .word   _start
    .word   _start
        //0xB0
    .word   _start
    .word   _start
    .word   _start
    .word   _start
.org 0x200
_start:

    movs r0, #0
    movs r1, #0
    movs r2, #0
    movs r3, #0    

    //gpiod
    ldr r0, =RCC_AHB1ENR
    ldr r1, [r0]
    ldr r2, =(1 << 6)
    orrs r1, r1, r2
    ldr r2, =(1 << 14)
    orrs r1, r1, r2    
    str r1, [r0]

    ldr r0, =PIO0_20
    ldr r1, [r0]
    ldr r2, =(1 << 4)
    eors r1, r1, r2
    str r1, [r0]

    ldr r0, =PIO0_21
    ldr r1, [r0]
    ldr r2, =(1 << 4)
    eors r1, r1, r2
    str r1, [r0]

    ldr r0, =PORT0_BASE
    ldr r1, [r0, #DIRP0]
    ldr r2,=(1<<20)|(1<<21)
    orrs r1, r1, r2
    str r1, [r0, #DIRP0]

loop:

    bl wait

    //port0 1000 0000
    ldr r0, =PORT0
    //ldr r1, [r0, #0]
    ldr r1, =(1<<20)
    //eors r1, r1, r2 //xor
    str r1, [r0, #0]

    bl wait

    //port0 1000 0000
    ldr r0, =PORT0
    //ldr r1, [r0, #0]
    ldr r1, =(1<<21)
    //eors r1, r1, r2 //xor
    str r1, [r0, #0]

    b loop

wait:

    movs r4, #0
wait3:
    movs r3, #0
wait1:
    movs r2, #0 
wait2:

    adds r2, r2, #1
    cmp r2, #255
    bne wait2

    adds r3, r3, #1    
    cmp r3, #255
    bne wait1

    adds r4, r4, #1    
    cmp r4, #55
    bne wait3    

    bx lr



