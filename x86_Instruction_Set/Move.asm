# > Move

# mov src, dest     # GAS Syntax
# mov dest, src     # Intel Syntax

# mov 는 move 를 나타냄. 이름이 mov 이긴 하지만, src 피연산자의 내용을 dest 피연산자로 복사함.
# 작업 뒤, 두 피연산자는 값은 내용을 가짐


#                                            mov 명령에 가능한 피연산자들

# |                                           src 피연산자                                          | dest 피연산자 |
# |      immediate value       |     register    |                      memory                      |               |
# |----------------------------|-----------------|--------------------------------------------------|---------------|
# | Yes (into larger register) | Yes (Same size) | Yes (레지스터가 회수한 메모리로 사이즈를 알아냄) | register      |
# | Yes (32-bit 값 까지)       | Yes             | No                                               | memory        |

# 이 명령에선 수정되는 플래그가 없음

# > 예시

.data
value:
    .long 2

.text
    .globl _start

_start:
    movl $6, %eax       # eax = 6
    movw %eax, value    # value = eax
    movl $0, %ebx       # ebx = 0
    movb %al, %bl       # bl = al

    movl value, %ebx    # ebx = value, value is 6, ebx = 6
    movl $value, %esi   # esi = @value, value 의 주소

    xorl %ebx, %ebx     # ebx ^ ebx = 0, ebx = 0

    movw value(, %ebx, 1), %bx

# Linux sys_exit
    movl %1, %eax       # eax = 1
    xorl %ebx, %ebx     # ebx = 0
    int 0x80