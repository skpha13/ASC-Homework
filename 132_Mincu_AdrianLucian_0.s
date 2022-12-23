.data
    fs: .asciz "%ld"
    fs1: .asciz "%ld "
    fs2: .asciz "\n"
    fs3: .asciz "%ld\n"
    matrice: .space 400
    linei: .space 4
    coloana: .space 4
    n: .space 4
    aux: .space 4

.text

citire:
    pushl %ebp
    mov %esp,%ebp

    # n= 12(%ebp)
    # matrice = 8(%ebp)

    pushl 12(%ebp)
    pushl $fs
    call scanf
    addl $8,%esp

    

    popl %ebp
    ret

.global main

main:
    pushl $aux
    pushl $fs
    call scanf
    addl $8,%esp

    movl aux,%eax

    cmp $1,%eax
    je cerinta_1

    cmp $2,%eax
    je cerinta_2

    jmp exit

cerinta_1:
    pushl $n
    pushl $matrice
    call citire
    addl $8,%esp

cerinta_2:
    pushl $n
    pushl $matrice
    call citire
    addl $8,%esp

exit:
    mov $1,%eax
    xor %ebx,%ebx
    int $0x80