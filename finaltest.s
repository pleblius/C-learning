	.file	"finaltest.c"
	.text
	.def	__main;	.scl	2;	.type	32;	.endef
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_endprologue
	call	__main
	xorl	%eax, %eax
	addq	$40, %rsp
	ret
	.seh_endproc
	.text
	.p2align 4
	.globl	decode
	.def	decode;	.scl	2;	.type	32;	.endef
	.seh_proc	decode
decode:
	.seh_endprologue
	subq	%rcx, %rdx
	movswl	%r9w, %r9d
	sarq	$2, %rdx
	imull	%edx, %r9d
	leal	(%r9,%r8), %eax
	ret
	.seh_endproc
	.ident	"GCC: (Rev3, Built by MSYS2 project) 13.2.0"
