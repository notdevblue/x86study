# > Move with sign extend

# movs src, dest        # GAS Syntax
# movsx dest, src       # Intel Syntax

# movsx는 move with sign extension 을 의미함.
# movsx 명령은 src 피연산자를 dest 피연산자로 복사하고, src에서 제공되지 않은 비트들을 src의 부호 비트로 채움 (최상위 비트)
# 이 명령은 부호 있는 작은 값을 큰 레지스터로 복사하는데 유용함.

# > Operands

# movsx는 movzx와 같은 피연산자를 요구함

# > Modified Flags

# movsx도 플래그를 수정하지 않음.

# > Example

.data

byteval:
    .byte   -24 # 0xe8

.text
    .global _start

_start:
    movsbw  byteval, %ax
    # %ax = 0xffe8

    movswl  %ax, %ebx
    # %ebx = 0xffffffe8

    movsbl  byteval, %esi
    # %esi = 0xffffffe8

# sysexit
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
