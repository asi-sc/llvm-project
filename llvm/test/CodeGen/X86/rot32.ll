; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- -mcpu=corei7 | FileCheck %s --check-prefix=CHECK32 --check-prefix=X86
; RUN: llc < %s -mtriple=i686-- -mcpu=corei7-avx | FileCheck %s --check-prefix=CHECK32 --check-prefix=SHLD
; RUN: llc < %s -mtriple=i686-- -mcpu=core-avx2 | FileCheck %s --check-prefix=CHECK32 --check-prefix=BMI2
; RUN: llc < %s -mtriple=x86_64-- -mcpu=corei7 | FileCheck %s --check-prefix=CHECK64 --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-- -mcpu=corei7-avx | FileCheck %s --check-prefix=CHECK64 --check-prefix=SHLD64
; RUN: llc < %s -mtriple=x86_64-- -mcpu=core-avx2 | FileCheck %s --check-prefix=CHECK64 --check-prefix=BMI264

define i32 @foo(i32 %x, i32 %y, i32 %z) nounwind readnone {
; CHECK32-LABEL: foo:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK32-NEXT:    roll %cl, %eax
; CHECK32-NEXT:    retl
;
; CHECK64-LABEL: foo:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movl %edx, %ecx
; CHECK64-NEXT:    movl %edi, %eax
; CHECK64-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK64-NEXT:    roll %cl, %eax
; CHECK64-NEXT:    retq
entry:
	%0 = shl i32 %x, %z
	%1 = sub i32 32, %z
	%2 = lshr i32 %x, %1
	%3 = or i32 %2, %0
	ret i32 %3
}

define i32 @bar(i32 %x, i32 %y, i32 %z) nounwind readnone {
; CHECK32-LABEL: bar:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK32-NEXT:    shldl %cl, %edx, %eax
; CHECK32-NEXT:    retl
;
; CHECK64-LABEL: bar:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movl %edx, %ecx
; CHECK64-NEXT:    movl %esi, %eax
; CHECK64-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK64-NEXT:    shldl %cl, %edi, %eax
; CHECK64-NEXT:    retq
entry:
	%0 = shl i32 %y, %z
	%1 = sub i32 32, %z
	%2 = lshr i32 %x, %1
	%3 = or i32 %2, %0
	ret i32 %3
}

define i32 @un(i32 %x, i32 %y, i32 %z) nounwind readnone {
; CHECK32-LABEL: un:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK32-NEXT:    rorl %cl, %eax
; CHECK32-NEXT:    retl
;
; CHECK64-LABEL: un:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movl %edx, %ecx
; CHECK64-NEXT:    movl %edi, %eax
; CHECK64-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK64-NEXT:    rorl %cl, %eax
; CHECK64-NEXT:    retq
entry:
	%0 = lshr i32 %x, %z
	%1 = sub i32 32, %z
	%2 = shl i32 %x, %1
	%3 = or i32 %2, %0
	ret i32 %3
}

define i32 @bu(i32 %x, i32 %y, i32 %z) nounwind readnone {
; CHECK32-LABEL: bu:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK32-NEXT:    shrdl %cl, %edx, %eax
; CHECK32-NEXT:    retl
;
; CHECK64-LABEL: bu:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movl %edx, %ecx
; CHECK64-NEXT:    movl %esi, %eax
; CHECK64-NEXT:    # kill: def $cl killed $cl killed $ecx
; CHECK64-NEXT:    shrdl %cl, %edi, %eax
; CHECK64-NEXT:    retq
entry:
	%0 = lshr i32 %y, %z
	%1 = sub i32 32, %z
	%2 = shl i32 %x, %1
	%3 = or i32 %2, %0
	ret i32 %3
}

define i32 @xfoo(i32 %x, i32 %y, i32 %z) nounwind readnone {
; X86-LABEL: xfoo:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll $7, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: xfoo:
; SHLD:       # %bb.0: # %entry
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shldl $7, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: xfoo:
; BMI2:       # %bb.0: # %entry
; BMI2-NEXT:    rorxl $25, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: xfoo:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll $7, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: xfoo:
; SHLD64:       # %bb.0: # %entry
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shldl $7, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: xfoo:
; BMI264:       # %bb.0: # %entry
; BMI264-NEXT:    rorxl $25, %edi, %eax
; BMI264-NEXT:    retq
entry:
	%0 = lshr i32 %x, 25
	%1 = shl i32 %x, 7
	%2 = or i32 %0, %1
	ret i32 %2
}

define i32 @xfoop(ptr %p) nounwind readnone {
; X86-LABEL: xfoop:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    roll $7, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: xfoop:
; SHLD:       # %bb.0: # %entry
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    movl (%eax), %eax
; SHLD-NEXT:    shldl $7, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: xfoop:
; BMI2:       # %bb.0: # %entry
; BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    rorxl $25, (%eax), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: xfoop:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    roll $7, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: xfoop:
; SHLD64:       # %bb.0: # %entry
; SHLD64-NEXT:    movl (%rdi), %eax
; SHLD64-NEXT:    shldl $7, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: xfoop:
; BMI264:       # %bb.0: # %entry
; BMI264-NEXT:    rorxl $25, (%rdi), %eax
; BMI264-NEXT:    retq
entry:
	%x = load i32, ptr %p
	%a = lshr i32 %x, 25
	%b = shl i32 %x, 7
	%c = or i32 %a, %b
	ret i32 %c
}

define i32 @xbar(i32 %x, i32 %y, i32 %z) nounwind readnone {
; CHECK32-LABEL: xbar:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK32-NEXT:    shldl $7, %ecx, %eax
; CHECK32-NEXT:    retl
;
; CHECK64-LABEL: xbar:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movl %edi, %eax
; CHECK64-NEXT:    shrdl $25, %esi, %eax
; CHECK64-NEXT:    retq
entry:
	%0 = shl i32 %y, 7
	%1 = lshr i32 %x, 25
	%2 = or i32 %0, %1
	ret i32 %2
}

define i32 @xun(i32 %x, i32 %y, i32 %z) nounwind readnone {
; X86-LABEL: xun:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll $25, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: xun:
; SHLD:       # %bb.0: # %entry
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shldl $25, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: xun:
; BMI2:       # %bb.0: # %entry
; BMI2-NEXT:    rorxl $7, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: xun:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll $25, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: xun:
; SHLD64:       # %bb.0: # %entry
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shldl $25, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: xun:
; BMI264:       # %bb.0: # %entry
; BMI264-NEXT:    rorxl $7, %edi, %eax
; BMI264-NEXT:    retq
entry:
	%0 = lshr i32 %x, 7
	%1 = shl i32 %x, 25
	%2 = or i32 %0, %1
	ret i32 %2
}

define i32 @xunp(ptr %p) nounwind readnone {
; X86-LABEL: xunp:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    roll $25, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: xunp:
; SHLD:       # %bb.0: # %entry
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    movl (%eax), %eax
; SHLD-NEXT:    shldl $25, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: xunp:
; BMI2:       # %bb.0: # %entry
; BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    rorxl $7, (%eax), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: xunp:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    roll $25, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: xunp:
; SHLD64:       # %bb.0: # %entry
; SHLD64-NEXT:    movl (%rdi), %eax
; SHLD64-NEXT:    shldl $25, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: xunp:
; BMI264:       # %bb.0: # %entry
; BMI264-NEXT:    rorxl $7, (%rdi), %eax
; BMI264-NEXT:    retq
entry:
	%x = load i32, ptr %p
	%a = lshr i32 %x, 7
	%b = shl i32 %x, 25
	%c = or i32 %a, %b
	ret i32 %c
}

define i32 @xbu(i32 %x, i32 %y, i32 %z) nounwind readnone {
; CHECK32-LABEL: xbu:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK32-NEXT:    shldl $25, %ecx, %eax
; CHECK32-NEXT:    retl
;
; CHECK64-LABEL: xbu:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movl %edi, %eax
; CHECK64-NEXT:    shldl $25, %esi, %eax
; CHECK64-NEXT:    retq
entry:
	%0 = lshr i32 %y, 7
	%1 = shl i32 %x, 25
	%2 = or i32 %0, %1
	ret i32 %2
}

define i32 @fshl(i32 %x) nounwind {
; X86-LABEL: fshl:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll $7, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshl:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shldl $7, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshl:
; BMI2:       # %bb.0:
; BMI2-NEXT:    rorxl $25, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshl:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll $7, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshl:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shldl $7, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshl:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $25, %edi, %eax
; BMI264-NEXT:    retq
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 7)
  ret i32 %f
}
declare i32 @llvm.fshl.i32(i32, i32, i32)

define i32 @fshl1(i32 %x) nounwind {
; X86-LABEL: fshl1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshl1:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shldl $1, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshl1:
; BMI2:       # %bb.0:
; BMI2-NEXT:    rorxl $31, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshl1:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshl1:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shldl $1, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshl1:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $31, %edi, %eax
; BMI264-NEXT:    retq
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 1)
  ret i32 %f
}

define i32 @fshl31(i32 %x) nounwind {
; X86-LABEL: fshl31:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    rorl %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshl31:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shldl $31, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshl31:
; BMI2:       # %bb.0:
; BMI2-NEXT:    rorxl $1, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshl31:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    rorl %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshl31:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shldl $31, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshl31:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $1, %edi, %eax
; BMI264-NEXT:    retq
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 31)
  ret i32 %f
}

define i32 @fshl_load(ptr %p) nounwind {
; X86-LABEL: fshl_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    roll $7, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshl_load:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    movl (%eax), %eax
; SHLD-NEXT:    shldl $7, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshl_load:
; BMI2:       # %bb.0:
; BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    rorxl $25, (%eax), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshl_load:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    roll $7, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshl_load:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl (%rdi), %eax
; SHLD64-NEXT:    shldl $7, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshl_load:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $25, (%rdi), %eax
; BMI264-NEXT:    retq
  %x = load i32, ptr %p
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 7)
  ret i32 %f
}

define i32 @fshr(i32 %x) nounwind {
; X86-LABEL: fshr:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    rorl $7, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshr:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shrdl $7, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshr:
; BMI2:       # %bb.0:
; BMI2-NEXT:    rorxl $7, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshr:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    rorl $7, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshr:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shrdl $7, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshr:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $7, %edi, %eax
; BMI264-NEXT:    retq
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 7)
  ret i32 %f
}
declare i32 @llvm.fshr.i32(i32, i32, i32)

define i32 @fshr1(i32 %x) nounwind {
; X86-LABEL: fshr1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    rorl %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshr1:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shrdl $1, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshr1:
; BMI2:       # %bb.0:
; BMI2-NEXT:    rorxl $1, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshr1:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    rorl %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshr1:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shrdl $1, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshr1:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $1, %edi, %eax
; BMI264-NEXT:    retq
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 1)
  ret i32 %f
}

define i32 @fshr31(i32 %x) nounwind {
; X86-LABEL: fshr31:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    roll %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshr31:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    shrdl $31, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshr31:
; BMI2:       # %bb.0:
; BMI2-NEXT:    rorxl $31, {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshr31:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    roll %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshr31:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl %edi, %eax
; SHLD64-NEXT:    shrdl $31, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshr31:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $31, %edi, %eax
; BMI264-NEXT:    retq
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 31)
  ret i32 %f
}

define i32 @fshr_load(ptr %p) nounwind {
; X86-LABEL: fshr_load:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    rorl $7, %eax
; X86-NEXT:    retl
;
; SHLD-LABEL: fshr_load:
; SHLD:       # %bb.0:
; SHLD-NEXT:    movl {{[0-9]+}}(%esp), %eax
; SHLD-NEXT:    movl (%eax), %eax
; SHLD-NEXT:    shrdl $7, %eax, %eax
; SHLD-NEXT:    retl
;
; BMI2-LABEL: fshr_load:
; BMI2:       # %bb.0:
; BMI2-NEXT:    movl {{[0-9]+}}(%esp), %eax
; BMI2-NEXT:    rorxl $7, (%eax), %eax
; BMI2-NEXT:    retl
;
; X64-LABEL: fshr_load:
; X64:       # %bb.0:
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    rorl $7, %eax
; X64-NEXT:    retq
;
; SHLD64-LABEL: fshr_load:
; SHLD64:       # %bb.0:
; SHLD64-NEXT:    movl (%rdi), %eax
; SHLD64-NEXT:    shrdl $7, %eax, %eax
; SHLD64-NEXT:    retq
;
; BMI264-LABEL: fshr_load:
; BMI264:       # %bb.0:
; BMI264-NEXT:    rorxl $7, (%rdi), %eax
; BMI264-NEXT:    retq
  %x = load i32, ptr %p
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 7)
  ret i32 %f
}
