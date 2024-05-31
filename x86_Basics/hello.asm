; https://wiki.kldp.org/HOWTO/html/Assembly-HOWTO/hello.html
; https://tldp.org/HOWTO/Assembly-HOWTO/hello.html
section .data

msg db "Hello World!", 0xa
len equ $ - msg

section .text

    global _start

_start:

mov eax, 4      ; write
mov ebx, 1      ;   stdout
mov ecx, msg,   ;   "Hello World!"
mov edx, len    ;   msg.len
int 0x80        

mov ebx, 0      ; code 0
mov eax, 1      ; return
int 0x80
