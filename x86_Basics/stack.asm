; # Stack

; 스택은 Last In First Out (LIFO) (또는 First In Last Out, FILO) 데이터 구조임.
; 데이터는 스택 위로 쌓이게 되고, 맨 위에 있는 데이터부터 가져옴.

mov ax, 006Ah
mov bx, F79Ah
mov cx, 1124h

push ax ; 스택은 0x006A 를 가지고 있음
push bx ; 이제 스택은 0x0006 과 0xF79A 를 가지고 있음
push cx ; 이제 스택은 0x0006, 0xF79A, 0x1124 를 가지고 있음

call do_stuff ; 뭔가 함

pop cx ; 0x1124 가 반환됨. 스택은 이제 0x0006, 0xF79A 를 가짐
pop bx ; 0xF79A 가 반한됨. 스택은 이제 0x0006 을 가짐
pop ax ; 0x0006 이 반환된. 스택은 이제 비어있음

; 스택은 함수나 프로시저에게 매개변수를 전달할 때 주로 사용되고, call 지침이 사용되었을 때 컨트롤 플로우를 추적하기 위해서도 사용됨.
; 일시적으로 레지스터를 저장하기 위해서도 사용됨
