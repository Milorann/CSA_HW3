	.intel_syntax noprefix
	.text
	.globl	factorials
	.data
	.align 32
	.type	factorials, @object
	.size	factorials, 168
factorials:                 # факториалы до 20 включительно
	.quad	1
	.quad	1
	.quad	2
	.quad	6
	.quad	24
	.quad	120
	.quad	720
	.quad	5040
	.quad	40320
	.quad	362880
	.quad	3628800
	.quad	39916800
	.quad	479001600
	.quad	6227020800
	.quad	87178291200
	.quad	1307674368000
	.quad	20922789888000
	.quad	355687428096000
	.quad	6402373705728000
	.quad	121645100408832000
	.quad	2432902008176640000
	.globl	bernulli
	.align 32
	.type	bernulli, @object
	.size	bernulli, 168
bernulli:                   # числа Бернулли до 20 включительно
	.long	0
	.long	1072693248
	.long	0
	.long	-1075838976
	.long	1431655765
	.long	1069897045
	.long	0
	.long	0
	.long	286331153
	.long	-1079963375
	.long	0
	.long	0
	.long	409044504
	.long	1066951046
	.long	0
	.long	0
	.long	286331153
	.long	-1079963375
	.long	0
	.long	0
	.long	911053669
	.long	1068721369
	.long	0
	.long	0
	.long	808649520
	.long	-1076874493
	.long	0
	.long	0
	.long	-1431655765
	.long	1072868010
	.long	0
	.long	0
	.long	1583242846
	.long	-1071882658
	.long	0
	.long	0
	.long	-1894521915
	.long	1078688847
	.long	0
	.long	0
	.long	1926227757
	.long	-1065318146
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"Cannot open file."
.LC2:
	.string	"%lf"
	.text
	.globl	input
	.type	input, @function
input:                              # подпрограмма считывания строки из файла
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi     # загрузка inp на стэк
	mov	rax, QWORD PTR -24[rbp]     # inp
	lea	rdx, .LC0[rip]              # строка формата открытия файла
	mov	rsi, rdx                    # 2-й аргумент для fopen ("r")
	mov	rdi, rax                    # 1-й аргумент для fopen (inp)
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax      # myfile = fopen(inp, "r")
	cmp	QWORD PTR -8[rbp], 0        # сравнения myfile с NULL
	jne	.L2
	lea	rdi, .LC1[rip]              # аргумент для printf (puts)
	call	puts@PLT
	mov	edi, 1                      # аргумент для exit
	call	exit@PLT
	
.L2:
	lea	rdx, -16[rbp]               # 3-й аргемнт для fscanf (x)
	lea	rsi, .LC2[rip]              # 2-й аргумент для fscanf (.LC2)
	mov	rdi, QWORD PTR -8[rbp]      # 1-й аргумент для fscanf (myfile)
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	
	mov	rdi, QWORD PTR -8[rbp]      # аргумент для fclose (myfile)
	call	fclose@PLT
	movsd	xmm0, QWORD PTR -16[rbp]    # возвращаемое значение (x)
	leave
	ret                                 # завершение подпрограммы
	.size	input, .-input
	
	.section	.rodata
.LC3:
	.string	"w"
	.align 8
.LC4:
	.string	"Number: %lf\nPower series answer: %lf\n"
	.align 8
.LC5:
	.string	"Precise answer: %lf\nTime spent: %ld\n"
	.text
	.globl	output
	.type	output, @function
output:                                 # подпрограмма вывода ответа в файл
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -24[rbp], rdi         # загрузка outp на стэк
	movsd	QWORD PTR -32[rbp], xmm0    # загрузка x на стэк
	movsd	QWORD PTR -40[rbp], xmm1    # загрузка ans_ps на стэк
	movsd	QWORD PTR -48[rbp], xmm2    # загрузка ans_precise на стэк
	mov	QWORD PTR -56[rbp], rsi         # загрузка t на стэк
	
	mov	rax, QWORD PTR -24[rbp]         # outp
	lea	rsi, .LC3[rip]                  # 2-й аргумент для fopen (.LC3)
	mov	rdi, rax                        # 1-й аргумент для fopen (outp)
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax          # myfile = fopen(outp, "w")
	
	movsd	xmm1, QWORD PTR -40[rbp]    # 4-й аргумент для fprintf (ans_ps)
	movsd	xmm0, QWORD PTR -32[rbp]    # 3-й аргумент для fprintf (x)
	mov	rdi, QWORD PTR -8[rbp]          # 1-й аргумент для fprintf (myfile)
	lea	rsi, .LC4[rip]                  # 2-й аргумент для fprintf (.LC4)
	mov	eax, 2
	call	fprintf@PLT
	
	mov	rdx, QWORD PTR -56[rbp]         # 4-й аргумент для fprintf (t)
	movq	xmm0, QWORD PTR -48[rbp]    # 3-й аргумент для fprintf (ans_precise)
	mov	rdi, QWORD PTR -8[rbp]          # 1-й аргумент для fprintf (myfile)
	lea	rsi, .LC5[rip]                  # 2-й аргумент для fprintf (.LC5)
	mov	eax, 1
	call	fprintf@PLT
	
	mov	rdi, QWORD PTR -8[rbp]          # аргумент для fclose (myfile)
	call	fclose@PLT
	leave
	ret                                 # завершение подпрограммы
	.size	output, .-output
	
	.globl	tg
	.type	tg, @function
tg:                                     # подпрограмма вычисления тангенса
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	movsd	QWORD PTR -24[rbp], xmm0    # загрузка x на стэк
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0     # ans = 0
	mov	DWORD PTR -12[rbp], 1           # i = 1
	jmp	.L6
.L9:
	mov	eax, DWORD PTR -12[rbp]         # i
	add	eax, eax                        # 2*i
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, bernulli[rip]              # bernulli
	movsd	xmm2, QWORD PTR [rdx+rax]   # bernulli[2 * i]
	movsd	QWORD PTR -48[rbp], xmm2    # bernulli[2 * i]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm1, DWORD PTR -12[rbp]    # 2-й аргумент для pow (i)
	movq	xmm0, QWORD PTR .LC7[rip]       # 1-й аргумент для pow (-4)
	call	pow@PLT
	
	mulsd	xmm0, QWORD PTR -48[rbp]        # bernulli[2 * i] * pow(-4, i)
	movsd	QWORD PTR -48[rbp], xmm0        # -//-
	pxor	xmm0, xmm0
	
	cvtsi2sd	xmm1, DWORD PTR -12[rbp]    # 2-й аргумент для pow (i)
	movq	xmm0, QWORD PTR .LC8[rip]       # 1-й аргумент для pow (4)
	call	pow@PLT
	
	movsd	xmm1, QWORD PTR .LC9[rip]       # 1
	subsd	xmm1, xmm0                      # 1 - pow(4, i)
	mulsd	xmm1, QWORD PTR -48[rbp]
	mov	eax, DWORD PTR -12[rbp]             # i
	add	eax, eax                            # 2*i
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, factorials[rip]                # factorials
	mov	rax, QWORD PTR [rdx+rax]            # factorials[2 * i]
	test	rax, rax
	js	.L7
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L8
.L7:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L8:
	divsd	xmm1, xmm0  # bernulli[2 * i] * pow(-4, i) * (1 - pow(4, i)) / factorials[2 * i]
	movsd	QWORD PTR -48[rbp], xmm1    # -//-
	fld	QWORD PTR -48[rbp]
	fstp	TBYTE PTR -48[rbp]
	mov	eax, DWORD PTR -12[rbp]         # i
	add	eax, eax                        # 2 * i
	sub	eax, 1                          # 2 * i - 1
	mov	DWORD PTR -28[rbp], eax         # 2 * i - 1
	fild	DWORD PTR -28[rbp]
	fld	QWORD PTR -24[rbp]              # x
	fxch	st(1)
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	call	powl@PLT                    # powl(x, 2 * i - 1)
	add	rsp, 32
	fld	TBYTE PTR -48[rbp]
	fmulp	st(1), st
	fld	QWORD PTR -8[rbp]
	faddp	st(1), st
	fstp	QWORD PTR -8[rbp]
	add	DWORD PTR -12[rbp], 1           # i++
.L6:
	cmp	DWORD PTR -12[rbp], 10          # i < 11
	jle	.L9
	movsd	xmm0, QWORD PTR -8[rbp]     # возвращаемое значение (ans)
	leave
	ret                                 # завершение подпрограммы
	.size	tg, .-tg
	
	.globl	generate
	.type	generate, @function
generate:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	
	mov	edi, 0                          # NULL для time
	call	time@PLT
	mov	edi, eax                        # time(NULL) для srand
	call	srand@PLT
	call	rand@PLT
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax               # rand()
	movsd	xmm1, QWORD PTR .LC11[rip]  # RAND_MAX / (1.5707 + 1.5707)
	divsd	xmm0, xmm1              # (rand() / (RAND_MAX / (1.5707 + 1.5707))
	movsd	xmm1, QWORD PTR .LC12[rip]  # 1.5707
	subsd	xmm0, xmm1      # (rand() / (RAND_MAX / (1.5707 + 1.5707)) - 1.5707
	movsd	QWORD PTR -8[rbp], xmm0     # x
	movsd	xmm0, QWORD PTR -8[rbp]     # return x
	leave
	ret                                 # завершение подпрограммы
	.size	generate, .-generate
	
	.section	.rodata
	.align 8
.LC7:                       # -4
	.long	0
	.long	-1072693248
	
	.align 8
.LC8:                       # 4
	.long	0
	.long	1074790400
	
	.align 8
.LC9:                       # 1
	.long	0
	.long	1072693248
	
	.align 8
.LC11:                      # RAND_MAX / (1.5707 + 1.5707)
	.long	1312589906
	.long	1103388546
	
	.align 8
.LC12:                      # 1.5707
	.long	1388133430
	.long	1073291670
