/*
    Print if digit is odd or even
    Luis Espino 2024

    output:
    [print "odd" or "even" from stdin]
*/

.global _start

.data
msg:
    .ascii "Enter 1 digit: "
even_msg:
    .ascii "even\n"
odd_msg:
    .ascii "odd\n"

.bss
input: .space 2

.text
_start:
    mov x0, 1          // stdout
    ldr x1, =msg       // load msg address
    mov x2, 15         // size of msg
    mov x8, 64         // write syscall number
    svc 0              // make syscall

    mov x0, 0          // stdin
    ldr x1, =input     // load input buffer address
    mov x2, 2          // size of input buffer with flush
    mov x8, 63         // read syscall number
    svc 0              // make syscall

    ldr x0, =input     // load input buffer address
    ldrb w1, [x0]      // load 1st digit from input
    sub w1, w1, 48     // convert ascii to number (0-9)
    and w2, w1, 1      // check parity (0 for even, 1 for odd)
    
    cmp w2, 0          // compare w2 with 0
    bne print_odd      // if not equal, branch to print_odd

print_even:
    ldr x1, =even_msg  // load even_msg address
    mov x2, 5          // size of "even\n"
    b print_result     // branch to print_result

print_odd:
    ldr x1, =odd_msg   // load odd_msg address
    mov x2, 4          // size of "odd\n"

print_result:
    mov x0, 1          // stdout
    mov x8, 64         // write syscall number
    svc 0              // make syscall

    mov x0, 0          // return value
    mov x8, 93         // exit syscall number
    svc 0              // make syscall
