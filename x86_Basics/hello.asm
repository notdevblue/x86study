; https://wiki.kldp.org/HOWTO/html/Assembly-HOWTO/hello.html
section .data

msg db "Hello World!", 0xa
len equ $ - msg

section .text

    global _start

_start:

mov edx, len
mov ecx, msg,
mov ebx, 1
mov eax, 4
int 0x80

mov ebx, 0
mov eax, 1
int 0x80