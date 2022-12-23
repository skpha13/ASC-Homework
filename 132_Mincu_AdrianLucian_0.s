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
    mov %esp,%ebp
    pushl %edi
    pushl %esi
    
    # n = 12(%ebp)
    # matrice = 8(%ebp)

    lea 12(%ebp),%edi
    pushl %edi
    pushl $fs
    call scanf
    addl $8,%esp

    # -400(ebp) = legaturi
    subl $400,%esp
    lea -400(%ebp),%edi
    movl $0,%ecx

    citire_legaturi:
        cmp 12(%ebp),%ecx
        je iesire

        pushl %ecx

        lea (%edi,%ecx,4),%esi
        pushl %esi
        pushl $fs
        call scanf
        addl $8,%esp

        popl %ecx
    
        addl $1,%ecx
        jmp citire_legaturi

    iesire:
        addl $400,%esp
        popl %esi
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

    jmp exit

exit:
    mov $1,%eax
    xor %ebx,%ebx
    int $0x80