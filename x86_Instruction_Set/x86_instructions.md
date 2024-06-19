# [X86 Instructions](https://en.wikibooks.org/wiki/X86_Assembly/X86_Instructions)

이 페이지에서는 x86 명령 집합에서의 다른 명령에 대해 깊히 알아볼 것.
편의와 페이지 길이를 줄이기 위해, 다른 명령들은 그룹으로 나뉘어 별개로 알아볼 것.

* [Data Transfer Instructions](https://en.wikibooks.org/wiki/X86_Assembly/Data_Transfer)
* [Control Flow Instructions](https://en.wikibooks.org/wiki/X86_Assembly/Control_Flow)
* [Arithemtic Instructions](https://en.wikibooks.org/wiki/X86_Assembly/Arithmetic)
* [Logic Instructions](https://en.wikibooks.org/wiki/X86_Assembly/Logic)
* [Shfit and Rotate Instructions](https://en.wikibooks.org/wiki/X86_Assembly/Shift_and_Rotate)
* [Other Instructions](https://en.wikibooks.org/wiki/X86_Assembly/Other_Instructions)
* [x86 Interrupts](https://en.wikibooks.org/wiki/X86_Assembly/X86_Interrupts)

추가 정보는, [resources](https://en.wikibooks.org/wiki/X86_Assembly/Resources) 섹션에 있음.

## Conventions

다음과 같은 템플릿은 피연산자가 없는 명령에 사용됨

```asm
Instr
```

다음과 같은 템플릿은 피연산자가 하나 있는 명령에 사용됨

```asm
Instr arg
```

다음과 같은 템플릿은 피연산자가 두개 있는 명령에 사용됨. 어셈블러별로 다른 명령 형식에 주의.

```asm
Instr src, dest     ; GAS Syntax
Instr desc, src     ; Intel Syntax
```

다음과 같은 템플릿은 피연산자가 세개 있는 명령에 사용됨. 어셈블러별로 다른 명령 형식의 주의.

```asm
Instr aux, src, dest        ; GAS Syntax
Instr dest, src, aux        ; Intel Syntax
```

### Suffixes

몇몇 명령 (윈도우 플렛폼 이외에서 빌드된 경우 특별히,) 에선 연산되는 데이터의 크기를 지정하기 위해 접미사가 필요함. 가능한 몇몇 접미사는 다음과 같음:

* `b` (byte) = 8 bits.
* `w` (word) = 16 bits.
* `l` (long) = 32 bits.
* `q` (quad) = 64 bits.

32-bit 환경에서의 `mov` 명령 예시. GAS 문법:

```asm
movl $0x000F, %eax  # 값 F 를 eax 레지스터에 저장함, mov"l".
```

Intel 문법에서는 접미사가 필요하지 않음. 레지스터 이름과 사용된 값으로 컴파일러가 데이터 크기를 알아냄.

```asm
MOV EAX, 0x000F
```
