.data

.text

.global main

main:

exit:
    mov $1,%eax
    xor %ebx,%ebx
    int $0x80