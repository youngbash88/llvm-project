; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=riscv32 -global-isel -global-isel-abort=1 -verify-machineinstrs < %s 2>&1 | FileCheck %s --check-prefixes=RV32
; RUN: llc -mtriple=riscv64 -global-isel -global-isel-abort=1 -verify-machineinstrs < %s 2>&1 | FileCheck %s --check-prefixes=RV64

define i16 @test_lshr_i48(i48 %x) {
; RV32-LABEL: test_lshr_i48:
; RV32:       # %bb.0:
; RV32-NEXT:    srli a0, a0, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: test_lshr_i48:
; RV64:       # %bb.0:
; RV64-NEXT:    srliw a0, a0, 16
; RV64-NEXT:    ret
  %lshr = lshr i48 %x, 16
  %trunc = trunc i48 %lshr to i16
  ret i16 %trunc
}

define i16 @test_ashr_i48(i48 %x) {
; RV32-LABEL: test_ashr_i48:
; RV32:       # %bb.0:
; RV32-NEXT:    srai a0, a0, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: test_ashr_i48:
; RV64:       # %bb.0:
; RV64-NEXT:    sraiw a0, a0, 16
; RV64-NEXT:    ret
  %ashr = ashr i48 %x, 16
  %trunc = trunc i48 %ashr to i16
  ret i16 %trunc
}

define i16 @test_shl_i48(i48 %x) {
; RV32-LABEL: test_shl_i48:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a0, a0, 8
; RV32-NEXT:    ret
;
; RV64-LABEL: test_shl_i48:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a0, a0, 8
; RV64-NEXT:    ret
  %shl = shl i48 %x, 8
  %trunc = trunc i48 %shl to i16
  ret i16 %trunc
}

; FIXME: Could use srlw to remove slli+srli.
define i16 @test_lshr_i48_2(i48 %x, i48 %y) {
; RV32-LABEL: test_lshr_i48_2:
; RV32:       # %bb.0:
; RV32-NEXT:    andi a2, a2, 15
; RV32-NEXT:    srl a0, a0, a2
; RV32-NEXT:    ret
;
; RV64-LABEL: test_lshr_i48_2:
; RV64:       # %bb.0:
; RV64-NEXT:    andi a1, a1, 15
; RV64-NEXT:    slli a0, a0, 32
; RV64-NEXT:    srli a0, a0, 32
; RV64-NEXT:    srl a0, a0, a1
; RV64-NEXT:    ret
  %and = and i48 %y, 15
  %lshr = lshr i48 %x, %and
  %trunc = trunc i48 %lshr to i16
  ret i16 %trunc
}

; FIXME: Could use sraw to remove the sext.w.
define i16 @test_ashr_i48_2(i48 %x, i48 %y) {
; RV32-LABEL: test_ashr_i48_2:
; RV32:       # %bb.0:
; RV32-NEXT:    andi a2, a2, 15
; RV32-NEXT:    sra a0, a0, a2
; RV32-NEXT:    ret
;
; RV64-LABEL: test_ashr_i48_2:
; RV64:       # %bb.0:
; RV64-NEXT:    andi a1, a1, 15
; RV64-NEXT:    sext.w a0, a0
; RV64-NEXT:    sra a0, a0, a1
; RV64-NEXT:    ret
  %and = and i48 %y, 15
  %ashr = ashr i48 %x, %and
  %trunc = trunc i48 %ashr to i16
  ret i16 %trunc
}

define i16 @test_shl_i48_2(i48 %x, i48 %y) {
; RV32-LABEL: test_shl_i48_2:
; RV32:       # %bb.0:
; RV32-NEXT:    andi a2, a2, 15
; RV32-NEXT:    sll a0, a0, a2
; RV32-NEXT:    ret
;
; RV64-LABEL: test_shl_i48_2:
; RV64:       # %bb.0:
; RV64-NEXT:    andi a1, a1, 15
; RV64-NEXT:    sll a0, a0, a1
; RV64-NEXT:    ret
  %and = and i48 %y, 15
  %shl = shl i48 %x, %and
  %trunc = trunc i48 %shl to i16
  ret i16 %trunc
}
