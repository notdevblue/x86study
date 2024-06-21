# > Data swap

# xchg src, dest        # GAS Synax
# xchg dest, src        # Intel Syntax

# xchg 는 exchange 를 나타냄. xchg 명령은 src 피연산자와 dest 피연산자 서로의 값을 바꿈.
# 세번의 mov 작업을 하는 것과 비슷함:
#   1. dest에서 임시 저장소로 (다른 레지스터)
#   2. src에서 dest로
#   3. 임시 저장소에서 src로

# 하지만 임시 저장소를 위한 추가 레지스터가 필요하지는 않음.

# 이 교환 패턴에서 연이은 세번의 mov 명령은 몇몇 아키텍터에선 DFU (Data Flow Unit)에서 감지되어서 특별한 취급을 하게 됨.
# xchg의 명령코드가 더 짧기는 함.

# 레지스터나 메모리 피연산자 조합이면 가능함. 하지만 메모리 피연산자는 최대 하나여야 함.
# 메모리 블럭끼리 교환은 불가능함.

# 이 명령에선 수정되는 플래그가 없음

# > 예시

.data

value:
    .long 2

.text
    .global _start

_start:
    movl    $54, %ebx
    xorl    %eax, %eax
    xchgl   value, %ebx         # value is 54, ebx is 2

    xchgw   %eax, value         # value is 0, eax is 54

    xchgb   %eax, %ebx          # eax is 2, ebx is 54

    xchgw   value(%eax), %eax

# Linux sys_exit
    mov     $1, %eax
    xorl    %ebx, %ebx
    init    $0x80

# Application

# 둘중 하나의 피연산자가 메모리 주소인 경우, 이 연산은 명시적 lock 접두가사 붙음
# 교환 연산은 원자성을 가지게 되고, 큰 퍼포먼스 페널티를 가지고 있음.

# 하지만 몇몇 플렛폼에서 두 레지스터(부분적이 아닌 전채)를 교환하는 것은 Register renamer 를 트리거함.
# 레지스터 리네이머는 그저 레지스터 이름을 바꾸는 유닛임. 그래서 데이터가 이동될 필요는 없음.
# 이는 매우 빠름 ("zero-latency" 로 브랜드됨). 레지스터 이름을 바꾸는 것은 아레의 이유 때문에 매우 유용할 수 있음.
#   * 몇몇 명령은 특정한 피연산자가 특정한 레지스터에 위치해있기를 요구함. 하지만 데이터는 다음에도 필요함
#   * 누산기 레지스터에 피연산자가 있는 경우, 일부 명령코드 인코딩이 더 짧음.

# xchg 명령은 16-bit 값의 바이트 순서를 바꾸는 것에 사용됨. (Little Endian -> Big Endian)
# bswap 명령은 32-, 64-bit 값만 지원하기 때문에, 부분 레지스터를 처리하며 바꿈. (xchg ah, al)

# nop 명령도 주목할 만 함, 0x90, xchgl %eax %eax 의 opcode 임.