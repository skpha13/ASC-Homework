.data
    fs: .asciz "%ld"
    fs1: .asciz "%ld "
    fs2: .asciz "\n"
    fs3: .asciz "%ld\n"
    matrice: .space 40000
    linei: .space 4
    coloana: .space 4
    n: .space 4
    aux: .space 4

.text

citire:
    pushl %ebp
    pushl %edi
    mov %esp,%ebp
    
    # n= 12(%ebp)
    # matrice = 8(%ebp)

    lea 12(%ebp),%edi
    pushl %edi
    pushl $fs
    call scanf
    addl $8,%esp

    pushl 12(%ebp)
    pushl $fs3
    call printf
    addl $8,%esp

    # -400(ebp) = legaturi
    addl $400,%esp
    lea -400(%ebp),%edi
    movl $0,%ecx

    # -404(%ebp) = variabila temporara
    addl $4,%esp
    movl $3,-404(%ebp)

    pushl 12(%ebp)
    pushl $fs3
    call printf
    addl $8,%esp

    citire_legaturi:
        cmp 12(%ebp),%ecx
        je iesire



        addl $1,%ecx
        jmp citire_legaturi

    iesire:
        subl $404,%esp
        popl %edi
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

    jmp exit

cerinta_2:
    pushl $n
    pushl $matrice
    call citire
    addl $8,%esp

exit:
    mov $1,%eax
    xor %ebx,%ebx
    int $0x80