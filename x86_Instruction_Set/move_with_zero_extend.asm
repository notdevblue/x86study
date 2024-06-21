# > Move with zero extend

# movz src, dest        # GAS Syntax
# movzx dest, src       # Intel Syntax

# movz는 move with zero 를 의미함. 일반적인 mov 처럼 movz 명령은 src의 데이터를 복사해서 dest 에 넣음.
# 하지만 src에서 제공되지 않은 dest의 남은 비트들은 0으로 채워짐. 이는 작고, 부호 없는 값을 큰 레지스터로 옮기기 좋음.

# > Operands

# dest는 레지스터여야 함
# src는 다른 레지스터이거나, 메모리 피연산자일 수 있음.
# 이 연산이 의미가 있게 하려면 dest 가 src 보다 커야 함.

# > Modified flags

# 없음

# > Example

.data

byteval:
    .byte   204

.text
    .global _start

_start:
    movzbw byteval, %ax     # eax 는 204임

    movzwl %ax, %ebx        # ebx 는 204임

    movzbl byteval, %esi    # esi 는 204임

# Linux sys_exit
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
