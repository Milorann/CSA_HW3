	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Wrong number of command line arguments. Termination."
	.align 8
.LC4:
	.string	"Wrong number for tg. Termination."
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 72
	mov	DWORD PTR -68[rbp], edi     # загрузка argс на стэк
	mov	QWORD PTR -80[rbp], rsi     # загрузка argv на стэк
	
	cmp	DWORD PTR -68[rbp], 5       # argc сранивается с 5
	je	.L2
	lea	rdi, .LC0[rip]              # аргумент для printf (puts)
	call	puts@PLT
	mov	edi, 1                      # аргумент для exit
	call	exit@PLT
	
.L2:
	mov	rax, QWORD PTR -80[rbp]         # получаем argv
	add	rax, 24                         # argv[3]
	mov	rdi, QWORD PTR [rax]            # аргумент atoi (argv[3])
	call	atoi@PLT
	mov	DWORD PTR -40[rbp], eax         # choice = atoi(argv[3])
	
	pxor	xmm0, xmm0                  
	movsd	QWORD PTR -24[rbp], xmm0    # x = 0
	
	cmp	DWORD PTR -40[rbp], 1           # choice сравнивается с 1
	jne	.L3
	mov	rax, QWORD PTR -80[rbp]         # получаем argv
	add	rax, 8                          # argv[1]
	mov	rdi, QWORD PTR [rax]            # аргумент input (argv[1])
	call	input@PLT
	movq	QWORD PTR -24[rbp], xmm0    # x = input(argv[1])
	
.L3:
	cmp	DWORD PTR -40[rbp], 2           # choice сравнивается с 2
	jne	.L4
	mov	eax, 0
	call	generate@PLT
	movq	QWORD PTR -24[rbp], xmm0    # x = generate()

.L4:
	movsd	xmm0, QWORD PTR .LC2[rip]   # -M_PI_2
	comisd	xmm0, QWORD PTR -24[rbp]    # сравнение -M_PI_2 с x
	jnb	.L5
	movsd	xmm0, QWORD PTR -24[rbp]    # x
	comisd	xmm0, QWORD PTR .LC3[rip]   # сравнение x с M_PI_2
	jb	.L11
	
.L5:
	lea	rdi, .LC4[rip]                  # аргумент для printf (puts)
	call	puts@PLT
	mov	edi, 1                          # аргумент для exit
	call	exit@PLT
	
.L11:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -32[rbp], xmm0    # ans = 0
	mov	edi, 0                          # аргумент для time
	call	time@PLT
	mov	QWORD PTR -48[rbp], rax         # time_t start = time(NULL)
	mov	DWORD PTR -36[rbp], 0           # i = 0
	jmp	.L8
	
.L9:
	movq	xmm0, QWORD PTR -24[rbp]    # аргумент для tg
	call	tg@PLT
	movq	QWORD PTR -32[rbp], xmm0    # ans = tg(x)
	add	DWORD PTR -36[rbp], 1           # i++
	
.L8:
	mov	rax, QWORD PTR -80[rbp]         # argv
	add	rax, 32                         # argv[4]
	mov	rdi, QWORD PTR [rax]            # аргумент для atoi (argv[4])
	call	atoi@PLT
	cmp	DWORD PTR -36[rbp], eax         # сравнение i с atoi(argv[4])
	jl	.L9
	mov	edi, 0                          # аргумент для time
	call	time@PLT
	mov	QWORD PTR -56[rbp], rax         # time_t end = time(NULL)
	
	mov	rbx, QWORD PTR -56[rbp]         # end
	sub	rbx, QWORD PTR -48[rbp]         # (end - start)
	mov	rax, QWORD PTR -24[rbp]         # x
	movq	xmm0, rax                   # аргумент для tan (x)
	call	tan@PLT
	movq	rcx, xmm0                   # tan(x)
	mov	rax, QWORD PTR -80[rbp]         # argv
	add	rax, 16                         # argv[2]
	mov	rax, QWORD PTR [rax]            # argv[2]
	movsd	xmm0, QWORD PTR -32[rbp]    # ans
	mov	rdx, QWORD PTR -24[rbp]         # x
	mov	rsi, rbx                        # 5-й аргумент для output (end - start)
	movq	xmm2, rcx                   # 4-й аргумент для output (tan(x))
	movapd	xmm1, xmm0                  # 3-й аргумент для output (ans)
	movq	xmm0, rdx                   # 2-й аргумент для output (x)
	mov	rdi, rax                        # 1-й аргумент для output (argv[2])
	call	output@PLT
	mov	eax, 0
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret                                 # завершение программы
	.size	main, .-main
	
	.section	.rodata
	.align 8
.LC2:                           # -M_PI_2
	.long	1413754136
	.long	-1074191877
	
	.align 8
.LC3:                           # M_PI_2
	.long	1413754136
	.long	1073291771
