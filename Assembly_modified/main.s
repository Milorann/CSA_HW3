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
	lea	rdi, .LC0[rip]
	call	puts@PLT
	mov	edi, 1
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
	movsd	xmm0, QWORD PTR .LC2[rip]
	comisd	xmm0, QWORD PTR -24[rbp]
	jnb	.L5
	movsd	xmm0, QWORD PTR -24[rbp]
	comisd	xmm0, QWORD PTR .LC3[rip]
	jb	.L11
.L5:
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L11:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -32[rbp], xmm0
	mov	edi, 0
	call	time@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	DWORD PTR -36[rbp], 0
	jmp	.L8
.L9:
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax
	call	tg@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	add	DWORD PTR -36[rbp], 1
.L8:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 32
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	DWORD PTR -36[rbp], eax
	jl	.L9
	mov	edi, 0
	call	time@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	sub	rax, QWORD PTR -48[rbp]
	mov	rbx, rax
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax
	call	tan@PLT
	movq	rcx, xmm0
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	movsd	xmm0, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	mov	rsi, rbx
	movq	xmm2, rcx
	movapd	xmm1, xmm0
	movq	xmm0, rdx
	mov	rdi, rax
	call	output@PLT
	mov	eax, 0
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC2:
	.long	1413754136
	.long	-1074191877
	.align 8
.LC3:
	.long	1413754136
	.long	1073291771
