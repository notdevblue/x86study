; https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture

; x86 아기택처는 8개의 General-Purpose Register (GPR), 6개의 Segment Register, 1개의 Flags Register와 Instruction Pointer 가 있음.
; x86 의 64비트 버전은 추가적인 레지스터가 있음.

; ## GPR 16비트 명명 규칙

; 8개의 GPR은 아레와 같음
; 1. Accumulator(누산기) Register   (AX). 산술 연산에 사용됨. 상수를 합쳐서 누산기에 넣는 연산코드는 1바이트임.
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
; 4. Extra Segment  (EX). 추가 데이터를 향한 포인터             (Extra 의 E, D 다음이 E 이기도 함)
; 5. F Segment      (FS). 추가 추가 데이터를 향한 포인터        (E 다음이 F)
; 6. G Segment      (GS). 추가 추가 추가 데이터를 향한 포인터   (F 다음이 G)

; 현대 운영 체재 (리눅스, FreeBSD, 윈도우)의 애플리케이션들은 거의 모든 세그먼트 레지스터를 같은 위치로 포인팅 함. (대신 페이징을 사용함)
; 대부분, FS 또는 GS 의 사용은 위의 규칙의 예외임. 특정 쓰레드의 데이터를 포인팅 함.

; ## EFLAGS Register

; EFLAGS 는 32비트로 이루어진 프로세서가 실행한 작업의 결과를 boolean 으로 기록하는 레지스터임.
; 비트들은 아레와 같음.

; 표 그려야 함.