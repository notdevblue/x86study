; https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture

; x86 아기택처는 8개의 General-Purpose Register (GPR), 6개의 Segment Register, 1개의 Flags Register와 Instruction Pointer 가 있음.
; x86 의 64비트 버전은 추가적인 레지스터가 있음.

; ## GPR 16비트 명명 규칙

; 8개의 GPR은 아레와 같음
; 1. Accumulator(누산기) register   (AX). 산술 연산에 사용됨. 상수를 합쳐서 누산기에 넣는 연산코드는 1바이트임.
; 2. Base register                  (BX). 데이터를 향한 포인터로 사용됨. (Segmented mode 일 때는 Segment register DS 에 위치함)
; 3. Couter register                (CX). 명령을 이동/회전, 반복할때 사용됨.
; 4. Stack Pointer register         (SP). 스택 맨 위를 향한 포인터.
; 5. Stack Base Pointer register    (BP). 스택 맨 아레 (기반)을 향한 포인터.
; 6. Destination Index register     (DI). stream 작업의 목적지를 향한 포인터.
; 7. Source Index register          (SI). stream 작업의 원본을 향한 포인터.
; 8. Data register                  (DX). 산술 연산과 입출력 연산에 사용됨.

; 위에서 설명한 GPR들의 순서는 이유가 있음.
; push-to-stack 연산과 동일한 순서임

; 모든 레지스터는 16비트와 32비트 모드로 접근이 가능함
; 16비트 모드에선, 레지스터는 위의 리스트의 두 글자 약어로 접근이 가능함 (AX, BX...)
; 32비트 모드에서는 두 글자 약어에 접두사 'E' (Extended) 를 붙여 접근이 가능함.
;   예를 들어, EAX 는 누산기 레지스터에 32비트 값으로 접근하는 것.
; 64비트 모드에서도 이와 동일하게 'R' (Register) 의 접두가사 붙음.
;   예를 들어 EAX 의 64비트 버전은 RAX 임.

; 위에서부터 4가지의 16비트 레지스터 (AX, CX, DX, BX)를 반으로 나눈 8비트로도 접근이 가능함
; 최하위 바이트 (LSB, least significant byte) 또는 low half 는 'X' 를 'L' 로 바꾼 약어로 접근이 가능함
; 최상위 바이트 (MSB, most significant byte) 또는 high half 는 'X' 를 'H' 로 바꾼 약어로 접근이 가능함
;   예를 들어, CL 은 카운터 레지스터의 LSB 이며, CH 은 MSB임.

; 총 5가지의 방법으로 누산기, 베이스, 카운터(계수기), 데이터 레지스터를 접근할 수 있음. 64비트, 32비트, 16비트, 8비트 LSB, 8비트 MSB.
; 나머지 4개의 레지스터는 4가지 방법인 64비트, 32비트, 16비트, 8비트로 접근이 가능함.
; 아레의 테이블이 이를 정리함

;                                          레지스터와 레지스터 일부를 접근하기 위한 식별자
;
; | Register | Accumulator	| Base	    | Counter	| Stack Pointer	| Stack Base Pointer	| Destination	| Source	| Data  |
; |----------|--------------|-----------|-----------|---------------|-----------------------|---------------|-----------|-------|
; | 64-bit	 | RAX	        | RBX	    | RCX	    | RSP	        | RBP	                | RDI	        | RSI	    | RDX   |
; | 32-bit	 | EAX		    | EBX		| ECX		| ESP		    | EBP		            | EDI		    | ESI	    | EDX   |
; | 16-bit	 | AX		    | BX		| CX		| SP		    | BP		            | DI		    | SI	    | DX    |
; | 8-bit	 | AH AL		| BH BL	    | CH CL	    | SPL		    | BPL		            | DIL		    | SIL	    | DH DL |

; ## Segment registers (세그먼트 레지스터)

; 6개의 세그먼트 레지스터는 아레와 같음
; 1. Stack Segment  (SS). 스택을 향한 포인터                    (Stack 의 S)
; 2. Code Segment   (CS). 코드를 향한 포인터                    (Code 의 C)
; 3. Data Segment   (DS). 데이터를 향한 포인터                  (Data 의 D)
; 4. Extra Segment  (ES). 추가 데이터를 향한 포인터             (Extra 의 E, D 다음이 E 이기도 함)
; 5. F Segment      (FS). 추가 추가 데이터를 향한 포인터        (E 다음이 F)
; 6. G Segment      (GS). 추가 추가 추가 데이터를 향한 포인터   (F 다음이 G)

; 현대 운영 체재 (리눅스, FreeBSD, 윈도우)의 애플리케이션들은 거의 모든 세그먼트 레지스터를 같은 위치로 포인팅 함. (대신 페이징을 사용함)
; 대부분, FS 또는 GS 의 사용은 위의 규칙의 예외임. 특정 쓰레드의 데이터를 포인팅 함.

; ## EFLAGS Register

; EFLAGS 는 32비트로 이루어진 프로세서가 실행한 작업의 결과를 boolean 으로 기록하는 레지스터임.
; 비트들은 아레와 같음.

; | 31 | 30 | 29 | 28 | 27 | 26 | 25 | 24 | 23 | 22 | 21 |  20 |  19 | 18 | 17 | 16 | 15 | 14 | 13  12 | 11 | 10 | 09 | 08 | 07 | 06 | 05 | 04 | 03 | 02 | 01 | 00 |
; |----|----|----|----|----|----|----|----|----|----|----|-----|-----|----|----|----|----|----|--------|----|----|----|----|----|----|----|----|----|----|----|----|
; |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0 |  0 | ID | VIP | VIF | AC | VM | RF |  0 | NT |  IOPL  | OF | DF | IF | TF | SF | ZF |  0 | AF |  0 | PF |  1 | CF |

; 0과 1로 이름된 비트는 예약된 비트이며, 변경되면 안됨

; 플래그가 사용되는 방식
; 00        CF      Carry Flag                              마지막 산술 연산이 레지스터 사이즈를 넘어서서 비트를 Carry(가져왔)(더하기)거나 borrow(빌려왔)(빼기)을때 설정됨. 하나의 레지스터가 보관하기에는 값이 너무 큰 Add-with-cary 또는 Subtract-with-borrow 연산이 이루어졌을 때 채크됨
; 02        PF      Parity Flag                             최하위 바이트에 설정된 바이트의 수가 2의 배수일 시 설정됨.
; 04        AF      Adjust Flag                             Binary-coded decimal(이진화 십진법) 산술 연산에서 Carry 나 Borrow 가 일어났을 때 설정됨.
; 06        ZF      Zero Flag                               연산의 결과가 0 일때 설정됨.
; 07        SF      Sign Flag                               연산의 결과가 음수일때 설정됨.
; 08        TF      Trap Flag                               스탭 바이 스탭 디버깅일 때 설정됨.
; 09        IF      Intrruption Flag                        인터럽트가 활성화되었을 때 설정됨.
; 10        DF      Direction Flag                          Stream 방향. 설정되었을 시, 문자열 연산에서 포인터는 증가하지 않고 줄어듬. 메모리를 거꾸로 읽게 됨.
; 11        OF      Overflow Flag                           부호 있는 산술 연산의 결과가 레지스터가 담기에 너무 큰 경우 설정됨.
; 12 ~ 13   IOPL    I/O Privilege Level Field (2 bits)      현재 프로세스의 I/O 권한 레벨.
; 14        NT      Nested Task Flag                        인터럽트의 체이닝을 컨트롤 함. 현제 프로세스가 다음 프로세서와 연결되어있을 때 설정됨.
; 16        RF      Resume Flag                             디버그 예외의 응답.
; 17        VM      Virtual-8086 Mode                       8086 호환 모드일때 설정됨.
; 18        AC      Alignment Check                         메모리 레퍼런스에 대한 정렬 검사가 끝났을 시 설정됨.
; 19        VIF     Virtual Interrupt Flag                  IF 의 가상 이미지.
; 20        VIP     Virutal Interrupt Pending Flag          인터럽트가 보류 중일때 설정됨.
; 21        ID      Identification Flag                     CPUID 지침이 지원될 때 설정됨.

; ## Instruction Pointer

; EIP 레지스터는 브랜칭이 되어있지 않다면 다음에 실행되야 하는 지침의 주소를 가지고 있음.
; EIP 는 call 지침 이후에 스택을 통해서만 읽을 수 있음.

; ## Memory

; x86 아기택처는 리틀 인디안임. 여러 바이트 값은 최하위 바이트부터 써진다는 뜻. (비트는 해당되지 않음, 바이트만 해당됨)
; 32비트 값인 B3B2B1B0 은 x86 에서 아레와 같이 메모리에 표기됨.

;   리틀 인디언 표기법
; |----|----|----|----|
; | B0 | B1 | B2 | B3 |
; |----|----|----|----|

; 예를 들어, 32비트 double word 0x1BA583D4 는 아레와 같이 메모리에 표기됨.

; 리틀 인디언 표기 예시
; |----|----|----|----|
; | D4 | 83 | A5 | 1B |
; |----|----|----|----|

; 메모리 덤프에선 0xD4 0x83 0xA5 0x1B 로 보임.

; ## Two's Complement Representation (2의 보수 표현)

; 2의 보수는 바이너리에서 음수를 표기하는 기본적인 방법임. 부호는 모든 바이트를 뒤집고 1 을 더함으로 바뀜.

; 2의 보수 예시

; |--------|------|
; | 시작   | 0001 |
; | 반전   | 1110 |
; | 1 추가 | 1111 |
; |--------|------|

; 0001 은 1을 나타냄
; 1111 은 -1을 나타냄
