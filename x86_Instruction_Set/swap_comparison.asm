# > Data swap based on comparison

# cmpxchg arg2, arg1    # GAS Syntax
# cmpxchg arg1, arg2    # Intel Syntax

# cmpxchg 는 compare and exchange 를 의미함. Exchange 는 오해의 소지가 있음, 실제로 데이터가 교환되지는 않기 때문임.

# cmpxchg 명령은 하나의 암시적 피연산자가 있음: arg1 에 따른 al / ax / eax 임.
#   1. 명령은 arg1을 al / ax / eax 와 비교함
#   2. 만약 같다면 arg1은 arg2가 됨. (arg1 = arg2)
#   3. 만약 다르다면 al / ax / eax 는 arg1이 됨.

# xchg와는 다르게 암시적 lock 접두사가 없음, 그래서 명령이 원자성을 가져야 한다면, lock이 접두사로 존재해야 함.

# > Operands

# arg2 -> 레지스터여야 함.
# arg1 -> 레지스터 또는 메모리일 수 있음.

# > Modified flags

# ZF := arg1 = ( al | ax | eax ) [arg1 크기에 따라..]
# CF, PF, AF, SF, OF 도 변경됨.
