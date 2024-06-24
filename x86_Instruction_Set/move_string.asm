; > Move String

; movsb     ; GAS, Intel Syntax

; movsb 명령은 esi에서 지정된 메모리 위치에 edi에서 지정된 위치에 있는 하나의 바이트를 복사함.
; direction flag이 설정되지 않았다면 esi와 edi는 연산 뒤 증가됨.
; direction flag이 설정되었다면 포인터는 감소됨. 이 경우, 복사는 역방향으로 진행될 것.
; 최상위 주소부터 ecx가 0이 될 때 까지 감소됨.

; > Operands

; 명시적인 피연산자는 없음. 하지만,
;   * ecx 반복의 횟수를 지정함
;   * esi 원본의 주소를 지정함
;   * edi 목적지 주소. 그리고,
;     DF (Direction flag)이 방향을 구분하기 위해 이용됨. (cld, std 명령을 통해 플래그 변경될 수 있음)

; > Modified flags

; 이 명령에서는 플래그가 수정되지 않음.

; > Example

section .text
    mov esi, mystr      ; mystr 주소를 esi 로 로드함
    mov edi, mystr2     ; mystr2 주소를 edi 로 로드함
    cld                 ; clear direction flag
    mov ecx, 6          ; 반복 횟수를 6으로 설정함
    rep movsb           ; 6회 반복

section .bss
    mystr2: resb 6

section .data
    mystr db "Hello", 0x0

; > Move word

; movsw     ; GAS, Intel Syntax

; movsw 명령은 1 word (2 바이트) 를 esi에서 제공된 위치에서 edi에서 제공된 위치로 복사함.
; movsb와 같은 행동을 하지만, bytes 대신 words 라는 차이가 있음.

; > Operands

; 없음

; > Modified flags

; 이 명령에서는 플래그가 수정되지 않음.

; > Example

section .code
    mov esi, mystr
    mov edi, mystr2
    cld
    mov ecx, 4          ; 한 연산당 하나의 word 를 가져오니까 (8 bytes = 4 words)
    rep movsw

section .bss
    mystr2: resb 8

section .data
    mystr db "AaBbCca", 0x0
