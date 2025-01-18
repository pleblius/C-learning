	.file	"test.c"
	.text
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	movl	$0, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.globl	f1
	.def	f1;	.scl	2;	.type	32;	.endef
	.seh_proc	f1
f1:
	.seh_endprologue
	addl	%edx, %ecx
	jne	.L4
	movl	$1, %eax
.L2:
	ret
.L4:
	movl	$0, %eax
	jmp	.L2
	.seh_endproc
	.globl	f2
	.def	f2;	.scl	2;	.type	32;	.endef
	.seh_proc	f2
f2:
	.seh_endprologue
	cmpl	%ecx, %edx
	jnb	.L7
	movl	%ecx, %eax
.L5:
	ret
.L7:
	movl	%edx, %eax
	jmp	.L5
	.seh_endproc
	.globl	f3
	.def	f3;	.scl	2;	.type	32;	.endef
	.seh_proc	f3
f3:
	.seh_endprologue
	movl	%edx, %eax
	orl	%ecx, %eax
	jne	.L11
.L8:
	ret
.L11:
	movl	$1, %eax
	jmp	.L8
	.seh_endproc
	.globl	f4
	.def	f4;	.scl	2;	.type	32;	.endef
	.seh_proc	f4
f4:
	.seh_endprologue
	movl	%edx, %eax
	cmpl	$1, %ecx
	setne	%dl
	cmpl	$1, %eax
	setne	%al
	orb	%dl, %al
	jne	.L14
	movl	$1, %eax
.L12:
	ret
.L14:
	movl	$0, %eax
	jmp	.L12
	.seh_endproc
	.globl	myloop
	.def	myloop;	.scl	2;	.type	32;	.endef
	.seh_proc	myloop
myloop:
	.seh_endprologue
	movl	$0, %eax
	jmp	.L16
.L17:
	leal	-1(%rdx,%rdx,2), %edx
	sall	$3, %edx
	addl	%edx, %eax
.L16:
	cmpl	%ecx, %edx
	jle	.L17
	ret
	.seh_endproc
	.globl	fn_jt
	.def	fn_jt;	.scl	2;	.type	32;	.endef
	.seh_proc	fn_jt
fn_jt:
	.seh_endprologue
	cmpl	$7, %ecx
	jg	.L19
	cmpl	$6, %ecx
	jge	.L20
	cmpl	$3, %ecx
	je	.L21
	cmpl	$5, %ecx
	je	.L21
.L22:
	leal	0(,%rcx,8), %eax
	jmp	.L18
.L19:
	cmpl	$8, %ecx
	jne	.L22
	movl	$0, %eax
	jmp	.L23
.L21:
	leal	0(,%rdx,8), %eax
	subl	%edx, %eax
	jmp	.L18
.L20:
	movl	%ecx, %eax
	subl	%edx, %eax
.L23:
	subl	%ecx, %eax
.L18:
	ret
	.seh_endproc
	.globl	sum_element
	.def	sum_element;	.scl	2;	.type	32;	.endef
	.seh_proc	sum_element
sum_element:
	.seh_endprologue
	movslq	%edx, %rdx
	movslq	%ecx, %rcx
	leaq	(%rcx,%rcx,2), %r8
	salq	$4, %r8
	subq	%rcx, %r8
	addq	%rdx, %r8
	leaq	(%rcx,%rcx,4), %rax
	leaq	(%rcx,%rax,2), %rax
	addq	%rdx, %rax
	leaq	mat2(%rip), %rdx
	movl	(%rdx,%rax,4), %eax
	leaq	mat1(%rip), %rdx
	addl	(%rdx,%r8,4), %eax
	ret
	.seh_endproc
	.globl	mat2
	.bss
	.align 32
mat2:
	.space 2068
	.globl	mat1
	.align 32
mat1:
	.space 2068
	.ident	"GCC: (Rev3, Built by MSYS2 project) 13.2.0"
