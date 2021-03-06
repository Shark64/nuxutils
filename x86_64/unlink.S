/* unlink.S

   Copyright (C) 2017 Stefan Bidigaray

   Written by: Stefan Bidigaray
   Date: September 2017

   This file is part of Nux Utilities.

   This Source Code Form is subject to the terms of the Mozilla Public
   License, v. 2.0. If a copy of the MPL was not distributed with this
   file, you can obtain one at http://mozilla.org/MPL/2.0/.
*/

#include "sysdep.h"

.section .text
	.global _start

_start:
	movq	(%rsp), %rbx	/* %rbx = argc */
	cmpq	$2, %rbx
	jne	.Lerror

	movq	16(%rsp), %rdi	/* get argv[1] */
	sys_unlink
	test	%rax, %rax
	jnz	.Lunlink_fail

	movl	$0, %edi
	sys_exit

.Lerror:
	movl	$EXIT_FAILURE, %edi
	sys_exit

.Lunlink_fail:
	negl	%eax
	movl	%eax, %edi
	sys_exit
