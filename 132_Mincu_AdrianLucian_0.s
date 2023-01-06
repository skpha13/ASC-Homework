.data
    fs: .asciz "%ld"
    fs1: .asciz "%ld "
    fs2: .asciz "\n"
    fs3: .asciz "%ld\n"
    matrice: .space 40000
    matrice_copy: .space 40000
    mres: .space 40000
    n: .space 4
    aux: .space 4
    k: .space 4
    i: .space 4
    j: .space 4

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
        je prelucrare_legaturi

        pushl %ecx

        lea (%edi,%ecx,4),%esi
        pushl %esi
        pushl $fs
        call scanf
        addl $8,%esp

        popl %ecx
    
        addl $1,%ecx
        jmp citire_legaturi

    prelucrare_legaturi:
        subl $8,%esp
        movl $0,%eax

        # %eax = index linie
        # -404(%ebp) = index coloana
        parcurgere_legaturi:
            cmp 12(%ebp),%eax
            je iesire

            movl %eax,-408(%ebp)
            movl (%edi,%eax,4),%edx
            mov $0,%ecx
            citire_valori:
                cmp %edx,%ecx
                je salt_2
                
                movl -408(%ebp),%eax

                pusha

                lea -404(%ebp),%esi
                pushl %esi
                pushl $fs
                call scanf
                addl $8,%esp

                popa
                pushl %edx

                mov 8(%ebp),%esi
                mull 12(%ebp)
                addl -404(%ebp),%eax
                movl $1,(%esi,%eax,4)

                popl %edx

                add $1,%ecx
                jmp citire_valori

            salt_2:
                movl -408(%ebp),%eax
                add $1,%eax
                jmp parcurgere_legaturi

    iesire:
        movl 12(%ebp),%eax

        addl $408,%esp
        popl %esi
        popl %edi
        popl %ebp
        ret

afisare:
    pushl %ebp
    mov %esp,%ebp
    pushl %edi
    pushl %ebx

    # n = 12(%ebp)
    # matrice = 8(%ebp)

    mov 8(%ebp),%edi

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
            movl -4(%ebp),%eax
            movl $0,%ecx

            add $1,%eax
            jmp for_linie

    iesire_2:
        addl $8,%esp
        popl %ebx
        popl %edi
        popl %ebp
        ret

initializare0:
    pushl %ebp
    mov %esp,%ebp
    pushl %edi

    # n = 12(%ebp)
    # matrice = 8(%ebp)

    mov 8(%ebp),%edi
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

matrix_mult:
    pushl %ebp
    mov %esp,%ebp
    pushl %edi
    pushl %esi
    pushl %ebx

    # n = 20(%ebp)
    # mres = 16(%ebp)
    # matrice = 12(%ebp)
    # matrice = 8(%ebp)

    subl $8,%esp

    movl $0,%eax
    movl $0,%ecx
    movl $0,-8(%ebp)

    mov 8(%ebp),%edi
    mov 12(%ebp),%esi

    for_linie_2:
        cmp 20(%ebp),%eax
        je iesire_4

        movl %eax,-4(%ebp)
        for_coloana_2:
            cmp 20(%ebp),%ecx
            je salt_3

            for_k:
                movl -8(%ebp),%ebx
                cmp 20(%ebp),%ebx
                je salt_k

                movl -4(%ebp),%eax
                mull 20(%ebp)
                addl -8(%ebp),%eax
                movl %eax,%ebx

                movl -8(%ebp),%eax
                mull 20(%ebp)
                addl %ecx,%eax

                mov 8(%ebp),%edi
                movl (%edi,%eax,4),%eax
                movl (%esi,%ebx,4),%ebx
                mull %ebx
                movl %eax,%ebx

                movl -4(%ebp),%eax
                mull 20(%ebp)
                addl %ecx,%eax
                mov 16(%ebp),%edi
                addl %ebx,(%edi,%eax,4)

                addl $1,-8(%ebp)
                jmp for_k
            
            salt_k:
                movl $0,-8(%ebp)
                add $1,%ecx
                jmp for_coloana_2

        salt_3:
            movl -4(%ebp),%eax
            movl $0,%ecx

            add $1,%eax
            jmp for_linie_2

    iesire_4:
        addl $8,%esp
        popl %ebx
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
    pushl n
    pushl $matrice
    call citire
    addl $8,%esp

    movl %eax,n

    pushl $k
    pushl $fs
    call scanf
    addl $8,%esp

    pushl $i
    pushl $fs
    call scanf
    addl $8,%esp

    pushl $j
    pushl $fs
    call scanf
    addl $8,%esp

    movl n,%eax
    mull %eax
    movl $0,%ecx
    lea matrice,%edi
    lea matrice_copy,%esi
    for_copy:
        cmp %eax,%ecx
        je jump

        movl (%edi,%ecx,4),%ebx
        movl %ebx,(%esi,%ecx,4)

        addl $1,%ecx
        jmp for_copy

    jump:
        movl k,%ecx
        subl $1,%ecx
        loop_lungime:
            cmp $0,%ecx
            je print

            movl %ecx,aux

            pushl n
            pushl $mres
            call initializare0
            addl $8,%esp

            pushl n
            pushl $mres
            pushl $matrice_copy
            pushl $matrice
            call matrix_mult
            addl $12,%esp

            movl n,%eax
            mull %eax
            movl $0,%ecx
            lea mres,%edi
            lea matrice_copy,%esi
            for_copy_2:
                cmp %eax,%ecx
                je break

                movl (%edi,%ecx,4),%ebx
                movl %ebx,(%esi,%ecx,4)

                addl $1,%ecx
                jmp for_copy_2

            break:
                movl aux,%ecx

                subl $1,%ecx
                jmp loop_lungime

    print:
        movl i,%eax
        movl j,%ecx

        movl k,%ebx
        cmp $1,%ebx
        je caz_special_0

        lea mres,%edi
        jmp caz_special_1

        caz_special_0:
            lea matrice,%edi

        caz_special_1:
            movl n,%ebx
            mull %ebx
            addl %ecx,%eax

            pushl (%edi,%eax,4)
            pushl $fs3
            call printf
            addl $8,%esp

            jmp exit

exit:
    mov $1,%eax
    xor %ebx,%ebx
    int $0x80