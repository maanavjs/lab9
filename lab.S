######################################################
# Lab 9 template file
######################################################

######################################################
# .data is where variables will reside.
# We define the following below so you know what 
# their values are.
.data
.global lowercase_string
lowercase_string:
    // Specify a string ending with '\0'
    .asciz "ece 362 is awesome!"

// Align to 4bytes boundary as we have a string above
.balign 4
######################################################


######################################################
# All code goes in the .text section
.text

.global asm_strlen
asm_strlen:
    /* uint32_t asm_strlen(char *str)
     * Take in a pointer to a string and return
     * its length up to the null terminating
     * character `\0`
    **/   

    /* Enter your code after this comment */
    li t0, 0
    beqz a0, strlen_done
strlen_loop:
    lbu t1, 0(a0)
    beqz t1, strlen_done
    addi a0, a0, 1
    addi t0, t0, 1
    j strlen_loop
strlen_done:
    mv a0, t0
    /* Enter your code above this comment */
    ret

.global asm_fib
asm_fib:
    /* void asm_fib(int *arr, uint32_t length)
     * Accept a pointer to an array of integer and
     * the length of the array, then generate fibonacci
     * series starting at `0` and store the result
     * back to the array `arr` at corresponding indices.
     **/

    /* Enter your code after this comment */
    beqz a0, fib_done
    beqz a1, fib_done
    li  t0, 0
    li t1, 1
    li t2, 0
    li t4, 1
fib_loop:
    bgeu t2, a1, fib_done
    bnez t2, fib_not0
    sw t0, 0(a0)
    j  fib_next
fib_not0:
    bne t2, t4, fib_general
    sw t1, 0(a0)
    j fib_next
fib_general:
    mv t3, t1
    add  t1, t1, t0
    mv t0, t3
    sw t1, 0(a0)
fib_next:
    addi a0, a0, 4
    addi t2, t2, 1
    j fib_loop
fib_done:
    /* Enter your code above this comment */
    ret

.global asm_toUppercase
asm_toUppercase:
    /* void asm_toUppercase(char *str)
     * loop through an entire string and only convert
     * the lowercase letter to uppercase, leaving the
     * rest of the string intact
     **/

    /* Enter your code after this comment */
    beqz a0, upper_done
    li t2, 97
    li t3, 122
upper_loop:
    lbu t0, 0(a0)
    beqz t0, upper_done
    blt t0, t2, upper_next
    blt t3, t0, upper_next
    addi t0, t0, -32
    sb t0, 0(a0)
upper_next:
    addi a0, a0, 1
    j upper_loop
upper_done:
    /* Enter your code above this comment */
    ret


######################################################