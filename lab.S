######################################################
# Lab 9 template file
######################################################

.data
.global lowercase_string
lowercase_string:
    .asciz "ece 362 is awesome!"

.balign 4
######################################################

.text

.global asm_strlen
asm_strlen:
    /* Enter your code after this comment */
    li   t0, 0               # length = 0
    beqz a0, strlen_done     # if (str == NULL) return 0
strlen_loop:
    lbu  t1, 0(a0)           # t1 = *str (load 1 byte)
    beqz t1, strlen_done     # if (*str == '\0') exit loop
    addi a0, a0, 1           # str++
    addi t0, t0, 1           # length++
    j    strlen_loop
strlen_done:
    mv   a0, t0              # return value goes in a0
    /* Enter your code above this comment */
    ret

.global asm_fib
asm_fib:
    /* Enter your code after this comment */
    beqz a0, fib_done        # if (arr == NULL) return
    beqz a1, fib_done        # if (length == 0) return
    li   t0, 0               # prev = 0
    li   t1, 1               # curr = 1
    li   t2, 0               # i = 0
    li   t4, 1               # constant 1, for the i == 1 check
fib_loop:
    bgeu t2, a1, fib_done    # exit when i >= length (unsigned)
    bnez t2, fib_not0        # if (i == 0) ...
    sw   t0, 0(a0)           #     arr[i] = prev
    j    fib_next
fib_not0:
    bne  t2, t4, fib_general # else if (i == 1) ...
    sw   t1, 0(a0)           #     arr[i] = curr
    j    fib_next
fib_general:                 # else
    mv   t3, t1              #     tmp = curr
    add  t1, t1, t0          #     curr += prev
    mv   t0, t3              #     prev = tmp
    sw   t1, 0(a0)           #     arr[i] = curr
fib_next:
    addi a0, a0, 4           # move to next int (4 bytes)
    addi t2, t2, 1           # i++
    j    fib_loop
fib_done:
    /* Enter your code above this comment */
    ret

.global asm_toUppercase
asm_toUppercase:
    /* Enter your code after this comment */
    beqz a0, upper_done      # if (str == NULL) return
    li   t2, 97              # 'a'
    li   t3, 122             # 'z'
upper_loop:
    lbu  t0, 0(a0)           # c = *str
    beqz t0, upper_done      # stop at '\0'
    blt  t0, t2, upper_next  # if c < 'a', skip
    blt  t3, t0, upper_next  # if c > 'z', skip
    addi t0, t0, -32         # c - 32 -> uppercase
    sb   t0, 0(a0)           # *str = c - 32 (store 1 byte)
upper_next:
    addi a0, a0, 1           # str++
    j    upper_loop
upper_done:
    /* Enter your code above this comment */
    ret

######################################################