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

    pushl 12(%ebp)
    pushl $matrice
    call initializare0
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
        movl 12(%ebp),%eax

        addl $400,%esp
        popl %esi
        popl %edi
        popl %ebp
        ret

afisare:
    pushl %ebp
    mov %esp,%ebp
    pushl %edi

    # n = 12(%ebp)
    # matrice = 8(%ebp)

    lea matrice,%edi

    subl $8,%esp

    movl $0,%eax
    movl $0,%ecx

    for_linie:
        cmp 12(%ebp),%eax
        je iesire_2

        movl %eax,-4(%ebp)
        for_coloana:
            movl -4(%ebp),%eax

            cmp 12(%ebp),%ecx
            je salt

            mov $0,%edx
            mull 12(%ebp)
            add %ecx,%eax

            movl %ecx,-8(%ebp)

            pushl (%edi,%eax,4)
            pushl $fs1
            call printf
            addl $8,%esp

            pushl $0
            call fflush
            addl $4,%esp

            movl -8(%ebp),%ecx

            add $1,%ecx
            jmp for_coloana

        salt:
            movl $4,%eax
            movl $1,%ebx
            movl $fs2,%ecx
            movl $2,%edx
            int $0x80

            movl -4(%ebp),%eax
            movl $0,%ecx

            add $1,%eax
            jmp for_linie

    iesire_2:
        addl $8,%esp
        popl %edi
        popl %ebp
        ret

initializare0:
    pushl %ebp
    mov %esp,%ebp
    pushl %edi

    # n = 12(%ebp)
    # matrice = 8(%ebp)

    lea matrice,%edi
    movl $0,%ecx

    movl $0,%edx
    movl 12(%ebp),%eax
    mull %eax

    for:
        cmp %eax,%ecx
        je iesire_3

        movl $0,(%edi,%ecx,4)

        add $1,%ecx
        jmp for

    iesire_3:
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
    pushl n
    pushl $matrice
    call citire
    addl $8,%esp

    movl %eax,n

    pushl n
    pushl $matrice
    call afisare
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