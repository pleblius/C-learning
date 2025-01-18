	.file	"vector.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "Invalid vector reference.\12\0"
	.text
	.p2align 4
	.def	vector_append.part.0;	.scl	3;	.type	32;	.endef
	.seh_proc	vector_append.part.0
vector_append.part.0:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.def	vector_destroy.part.0;	.scl	3;	.type	32;	.endef
	.set	vector_destroy.part.0,vector_append.part.0
	.def	vector_print.part.0;	.scl	3;	.type	32;	.endef
	.set	vector_print.part.0,vector_append.part.0
	.def	vector_clear.part.0;	.scl	3;	.type	32;	.endef
	.set	vector_clear.part.0,vector_append.part.0
	.def	vector_size.part.0;	.scl	3;	.type	32;	.endef
	.set	vector_size.part.0,vector_append.part.0
	.def	vector_pop_last.part.0;	.scl	3;	.type	32;	.endef
	.set	vector_pop_last.part.0,vector_append.part.0
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "Vector capacity must be greater than 0.\12\0"
	.align 8
.LC2:
	.ascii "Vector memory allocation failed.\12\0"
	.align 8
.LC3:
	.ascii "Array memory allocation failed.\12\0"
	.text
	.p2align 4
	.globl	vector_create_cap
	.def	vector_create_cap;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_create_cap
vector_create_cap:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx
	testl	%ecx, %ecx
	jle	.L7
	movl	$16, %ecx
	call	malloc
	movq	%rax, %rsi
	testq	%rax, %rax
	je	.L8
	movl	$0, 8(%rax)
	movslq	%ebx, %rcx
	movl	%ebx, 12(%rax)
	salq	$3, %rcx
	call	malloc
	movq	%rax, (%rsi)
	testq	%rax, %rax
	je	.L9
	movq	%rsi, %rax
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L7:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$40, %r8d
	movl	$1, %edx
	leaq	.LC1(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L9:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$32, %r8d
	movl	$1, %edx
	leaq	.LC3(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L8:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$33, %r8d
	movl	$1, %edx
	leaq	.LC2(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_create
	.def	vector_create;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_create
vector_create:
	.seh_endprologue
	movl	$10, %ecx
	jmp	vector_create_cap
	.seh_endproc
	.p2align 4
	.globl	vector_expand
	.def	vector_expand;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_expand
vector_expand:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L20
	movq	(%rcx), %rsi
	movslq	12(%rcx), %rcx
	movq	%rcx, %rdi
	salq	$4, %rcx
	call	malloc
	movq	%rax, (%rbx)
	testq	%rax, %rax
	je	.L21
	movl	8(%rbx), %edx
	addl	%edi, %edi
	movl	%edi, 12(%rbx)
	testl	%edx, %edx
	jle	.L14
	movq	(%rsi), %rcx
	movl	%edx, %r8d
	salq	$3, %r8
	movq	%rcx, (%rax)
	movl	$8, %eax
	cmpl	$1, %edx
	je	.L14
	.p2align 4,,10
	.p2align 3
.L16:
	movq	(%rsi,%rax), %rcx
	movq	(%rbx), %rdx
	movq	%rcx, (%rdx,%rax)
	addq	$8, %rax
	cmpq	%r8, %rax
	jne	.L16
.L14:
	movq	%rsi, %rcx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	jmp	free
.L20:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L21:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$32, %r8d
	movl	$1, %edx
	leaq	.LC3(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_shrink
	.def	vector_shrink;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_shrink
vector_shrink:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L31
	movq	(%rcx), %rsi
	movslq	12(%rcx), %rcx
	movq	%rcx, %rdi
	salq	$3, %rcx
	shrq	%rcx
	call	malloc
	movq	%rax, (%rbx)
	testq	%rax, %rax
	je	.L32
	movl	%edi, %edx
	shrl	$31, %edx
	addl	%edi, %edx
	sarl	%edx
	movl	%edx, 12(%rbx)
	movl	8(%rbx), %edx
	testl	%edx, %edx
	jle	.L25
	movq	(%rsi), %rcx
	movl	%edx, %r8d
	salq	$3, %r8
	movq	%rcx, (%rax)
	movl	$8, %eax
	cmpl	$1, %edx
	je	.L25
	.p2align 4,,10
	.p2align 3
.L27:
	movq	(%rsi,%rax), %rcx
	movq	(%rbx), %rdx
	movq	%rcx, (%rdx,%rax)
	addq	$8, %rax
	cmpq	%r8, %rax
	jne	.L27
.L25:
	movq	%rsi, %rcx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	jmp	free
.L31:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L32:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$32, %r8d
	movl	$1, %edx
	leaq	.LC3(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.section .rdata,"dr"
.LC4:
	.ascii "Index must be non-negative.\12\0"
.LC5:
	.ascii "Index exceeds vector length.\12\0"
	.text
	.p2align 4
	.globl	vector_insert
	.def	vector_insert;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_insert
vector_insert:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	movslq	%edx, %rsi
	movq	%r8, %rdi
	testq	%rcx, %rcx
	je	.L43
	testl	%esi, %esi
	js	.L44
	movl	8(%rcx), %r10d
	cmpl	%esi, %r10d
	jl	.L45
	cmpl	12(%rcx), %r10d
	je	.L46
.L37:
	leal	-1(%r10), %eax
	cmpl	%eax, %esi
	jg	.L40
	movl	%r10d, %ecx
	movslq	%r10d, %rdx
	cltq
	subl	%esi, %ecx
	salq	$3, %rax
	subl	$1, %ecx
	subq	%rcx, %rdx
	leaq	-16(,%rdx,8), %r9
	.p2align 4,,10
	.p2align 3
.L39:
	movq	(%rbx), %rdx
	movq	(%rdx,%rax), %rcx
	movq	%rcx, 8(%rdx,%rax)
	subq	$8, %rax
	cmpq	%rax, %r9
	jne	.L39
.L40:
	movq	(%rbx), %rax
	addl	$1, %r10d
	movq	%rdi, (%rax,%rsi,8)
	movl	%r10d, 8(%rbx)
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	call	vector_expand
	movl	8(%rbx), %r10d
	jmp	.L37
.L45:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$29, %r8d
	movl	$1, %edx
	leaq	.LC5(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L44:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$28, %r8d
	movl	$1, %edx
	leaq	.LC4(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L43:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_append
	.def	vector_append;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_append
vector_append:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rbx
	movq	%rdx, %rsi
	testq	%rcx, %rcx
	je	.L50
	movslq	8(%rcx), %rax
	cmpl	12(%rcx), %eax
	je	.L51
.L49:
	movq	(%rbx), %rcx
	leal	1(%rax), %r8d
	movl	%r8d, 8(%rbx)
	movq	%rsi, (%rcx,%rax,8)
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
	.p2align 4,,10
	.p2align 3
.L51:
	call	vector_expand
	movslq	8(%rbx), %rax
	jmp	.L49
.L50:
	call	vector_append.part.0
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_set
	.def	vector_set;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_set
vector_set:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L56
	testl	%edx, %edx
	js	.L57
	cmpl	%edx, 8(%rcx)
	jl	.L58
	movq	(%rcx), %rax
	movslq	%edx, %rdx
	leaq	(%rax,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%r8, (%rax)
	movq	%rdx, %rax
	addq	$40, %rsp
	ret
.L56:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L58:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$29, %r8d
	movl	$1, %edx
	leaq	.LC5(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L57:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$28, %r8d
	movl	$1, %edx
	leaq	.LC4(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_get
	.def	vector_get;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_get
vector_get:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L63
	testl	%edx, %edx
	js	.L64
	cmpl	%edx, 8(%rcx)
	jl	.L65
	movq	(%rcx), %rax
	movslq	%edx, %rdx
	movq	(%rax,%rdx,8), %rax
	addq	$40, %rsp
	ret
.L63:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L65:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$29, %r8d
	movl	$1, %edx
	leaq	.LC5(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
.L64:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$28, %r8d
	movl	$1, %edx
	leaq	.LC4(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_pop_last
	.def	vector_pop_last;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_pop_last
vector_pop_last:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L78
	movl	8(%rcx), %edx
	xorl	%eax, %eax
	testl	%edx, %edx
	je	.L66
	subl	$1, %edx
	call	vector_get
	movslq	12(%rbx), %rdx
	movl	8(%rbx), %ecx
	movq	%rdx, %r8
	imulq	$1431655766, %rdx, %rdx
	subl	$1, %ecx
	movl	%r8d, %r9d
	movl	%ecx, 8(%rbx)
	sarl	$31, %r9d
	shrq	$32, %rdx
	subl	%r9d, %edx
	cmpl	%edx, %ecx
	jge	.L66
	cmpl	$19, %r8d
	jg	.L79
.L66:
	addq	$48, %rsp
	popq	%rbx
	ret
	.p2align 4,,10
	.p2align 3
.L79:
	movq	%rbx, %rcx
	movq	%rax, 40(%rsp)
	call	vector_shrink
	movq	40(%rsp), %rax
	addq	$48, %rsp
	popq	%rbx
	ret
.L78:
	call	vector_pop_last.part.0
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_peek_last
	.def	vector_peek_last;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_peek_last
vector_peek_last:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L83
	movl	8(%rcx), %edx
	testl	%edx, %edx
	je	.L82
	subl	$1, %edx
	addq	$40, %rsp
	jmp	vector_get
	.p2align 4,,10
	.p2align 3
.L82:
	xorl	%eax, %eax
	addq	$40, %rsp
	ret
.L83:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$26, %r8d
	movl	$1, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
	movl	$1, %ecx
	call	exit
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_size
	.def	vector_size;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_size
vector_size:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	testq	%rcx, %rcx
	je	.L86
	movl	8(%rcx), %eax
	addq	$40, %rsp
	ret
.L86:
	call	vector_size.part.0
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_clear
	.def	vector_clear;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_clear
vector_clear:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movq	%rcx, %rsi
	testq	%rcx, %rcx
	je	.L96
	movl	8(%rcx), %eax
	testl	%eax, %eax
	je	.L87
	jle	.L90
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L91:
	movq	(%rsi), %rax
	movq	(%rax,%rbx,8), %rcx
	call	free
	movq	(%rsi), %rax
	movq	$0, (%rax,%rbx,8)
	addq	$1, %rbx
	cmpl	%ebx, 8(%rsi)
	jg	.L91
.L90:
	movl	$0, 8(%rsi)
.L87:
	addq	$40, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L96:
	call	vector_clear.part.0
	nop
	.seh_endproc
	.section .rdata,"dr"
.LC6:
	.ascii "Array: \0"
.LC7:
	.ascii "%p \0"
.LC8:
	.ascii "\12Size: %d \12\0"
.LC9:
	.ascii "Capacity: %d \12\0"
	.text
	.p2align 4
	.globl	vector_print
	.def	vector_print;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_print
vector_print:
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rsi
	testq	%rcx, %rcx
	je	.L102
	leaq	.LC6(%rip), %rcx
	call	printf
	movl	8(%rsi), %edx
	testl	%edx, %edx
	jle	.L99
	xorl	%ebx, %ebx
	leaq	.LC7(%rip), %rdi
	.p2align 4,,10
	.p2align 3
.L100:
	movq	(%rsi), %rax
	movq	%rdi, %rcx
	movq	(%rax,%rbx,8), %rdx
	addq	$1, %rbx
	call	printf
	movl	8(%rsi), %edx
	cmpl	%ebx, %edx
	jg	.L100
.L99:
	leaq	.LC8(%rip), %rcx
	call	printf
	movl	12(%rsi), %edx
	leaq	.LC9(%rip), %rcx
	addq	$32, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	jmp	printf
.L102:
	call	vector_print.part.0
	nop
	.seh_endproc
	.p2align 4
	.globl	vector_destroy
	.def	vector_destroy;	.scl	2;	.type	32;	.endef
	.seh_proc	vector_destroy
vector_destroy:
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, %rbx
	testq	%rcx, %rcx
	je	.L105
	call	vector_clear
	movq	(%rbx), %rcx
	addq	$32, %rsp
	popq	%rbx
	jmp	free
.L105:
	call	vector_destroy.part.0
	nop
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC10:
	.ascii "Please choose one of the following options:\0"
.LC11:
	.ascii "0: Exit program\0"
.LC12:
	.ascii "1: Print the existing list\0"
	.align 8
.LC13:
	.ascii "2: Add a value to the end of the array\0"
	.align 8
.LC14:
	.ascii "3: Add a value at a given index\0"
	.align 8
.LC15:
	.ascii "4: Set a value at a given index\0"
	.align 8
.LC16:
	.ascii "5: Print a value at a given index\0"
	.align 8
.LC17:
	.ascii "6: Print the last value and remove it from the list\0"
	.align 8
.LC18:
	.ascii "7: Print the list's current size\0"
	.align 8
.LC19:
	.ascii "8: Clear the list of all elements\0"
	.text
	.p2align 4
	.globl	print_prompt
	.def	print_prompt;	.scl	2;	.type	32;	.endef
	.seh_proc	print_prompt
print_prompt:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	movl	$10, %ecx
	call	putchar
	leaq	.LC10(%rip), %rcx
	call	puts
	leaq	.LC11(%rip), %rcx
	call	puts
	leaq	.LC12(%rip), %rcx
	call	puts
	leaq	.LC13(%rip), %rcx
	call	puts
	leaq	.LC14(%rip), %rcx
	call	puts
	leaq	.LC15(%rip), %rcx
	call	puts
	leaq	.LC16(%rip), %rcx
	call	puts
	leaq	.LC17(%rip), %rcx
	call	puts
	leaq	.LC18(%rip), %rcx
	call	puts
	leaq	.LC19(%rip), %rcx
	addq	$40, %rsp
	jmp	puts
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC20:
	.ascii "Value: \0"
.LC21:
	.ascii "%d\0"
.LC22:
	.ascii "Index: \0"
.LC23:
	.ascii "Index: %d, Value: %p \12\0"
.LC24:
	.ascii "Pop Last: %p \12\0"
.LC25:
	.ascii "Size: %p \12\0"
.LC26:
	.ascii "List cleared\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	.seh_endprologue
	leaq	.LC21(%rip), %rdi
	leaq	.L121(%rip), %rbx
	call	__main
	movl	$10, %ecx
	leaq	40(%rsp), %rsi
	movl	$0, 40(%rsp)
	movl	$0, 44(%rsp)
	call	vector_create_cap
	movq	%rax, %rbp
	.p2align 4,,10
	.p2align 3
.L120:
	call	print_prompt
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	call	scanf
	cmpl	$8, 40(%rsp)
	ja	.L120
	movl	40(%rsp), %eax
	movslq	(%rbx,%rax,4), %rax
	addq	%rbx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L121:
	.long	.L109-.L121
	.long	.L110-.L121
	.long	.L112-.L121
	.long	.L113-.L121
	.long	.L114-.L121
	.long	.L115-.L121
	.long	.L116-.L121
	.long	.L117-.L121
	.long	.L119-.L121
	.section	.text.startup,"x"
	.p2align 4,,10
	.p2align 3
.L117:
	testq	%rbp, %rbp
	je	.L124
	movl	8(%rbp), %edx
	leaq	.LC25(%rip), %rcx
	call	printf
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L116:
	movq	%rbp, %rcx
	call	vector_pop_last
	leaq	.LC24(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L115:
	leaq	.LC22(%rip), %rcx
	call	printf
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	call	scanf
	movl	40(%rsp), %edx
	movq	%rbp, %rcx
	call	vector_get
	movl	40(%rsp), %edx
	leaq	.LC23(%rip), %rcx
	movq	%rax, %r8
	call	printf
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L114:
	leaq	.LC20(%rip), %rcx
	call	printf
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	call	scanf
	leaq	.LC22(%rip), %rcx
	call	printf
	leaq	44(%rsp), %rdx
	movq	%rdi, %rcx
	call	scanf
	movl	44(%rsp), %edx
	movq	%rsi, %r8
	movq	%rbp, %rcx
	call	vector_set
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L113:
	leaq	.LC20(%rip), %rcx
	call	printf
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	call	scanf
	leaq	.LC22(%rip), %rcx
	call	printf
	leaq	44(%rsp), %rdx
	movq	%rdi, %rcx
	call	scanf
	movl	44(%rsp), %edx
	movq	%rsi, %r8
	movq	%rbp, %rcx
	call	vector_insert
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L112:
	leaq	.LC20(%rip), %rcx
	call	printf
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	call	scanf
	movq	%rsi, %rdx
	movq	%rbp, %rcx
	call	vector_append
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L110:
	movq	%rbp, %rcx
	call	vector_print
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L109:
	movq	%rbp, %rcx
	call	vector_destroy
	xorl	%eax, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.p2align 4,,10
	.p2align 3
.L119:
	leaq	.LC26(%rip), %rcx
	call	puts
	movq	%rbp, %rcx
	call	vector_clear
	jmp	.L120
.L124:
	call	vector_size.part.0
	nop
	.seh_endproc
	.ident	"GCC: (Rev3, Built by MSYS2 project) 13.2.0"
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	scanf;	.scl	2;	.type	32;	.endef
