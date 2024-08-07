// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64 -target-feature +sve2 -target-feature +sve2p1 -target-feature +sve-b16b16 -target-feature +sve -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64 -target-feature +sve2 -target-feature +sve2p1 -target-feature +sve-b16b16 -target-feature +sve -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve2 -target-feature +sve2p1 -target-feature +sve-b16b16 -target-feature +sve -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve2 -target-feature +sve2p1 -target-feature +sve-b16b16 -target-feature +sve -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64 -target-feature +sve2 -target-feature +sve2p1 -target-feature +sve-b16b16 -target-feature +sve -target-feature -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3) A1##A2##A3
#endif

// CHECK-LABEL: @test_svmul_lane_bf16_idx1(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmul.lane.nxv8bf16(<vscale x 8 x bfloat> [[OP1:%.*]], <vscale x 8 x bfloat> [[OP2:%.*]], i32 1)
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z25test_svmul_lane_bf16_idx1u14__SVBfloat16_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmul.lane.nxv8bf16(<vscale x 8 x bfloat> [[OP1:%.*]], <vscale x 8 x bfloat> [[OP2:%.*]], i32 1)
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
svbfloat16_t test_svmul_lane_bf16_idx1(svbfloat16_t op1, svbfloat16_t op2)
{
  return SVE_ACLE_FUNC(svmul_lane, _bf16, )(op1, op2, 1);
}

// CHECK-LABEL: @test_svmul_lane_bf16_idx3(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmul.lane.nxv8bf16(<vscale x 8 x bfloat> [[OP1:%.*]], <vscale x 8 x bfloat> [[OP2:%.*]], i32 3)
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z25test_svmul_lane_bf16_idx3u14__SVBfloat16_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmul.lane.nxv8bf16(<vscale x 8 x bfloat> [[OP1:%.*]], <vscale x 8 x bfloat> [[OP2:%.*]], i32 3)
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
svbfloat16_t test_svmul_lane_bf16_idx3(svbfloat16_t op1, svbfloat16_t op2)
{
  return SVE_ACLE_FUNC(svmul_lane, _bf16, )(op1, op2, 3);
}

// CHECK-LABEL: @test_svmul_lane_bf16_idx7(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmul.lane.nxv8bf16(<vscale x 8 x bfloat> [[OP1:%.*]], <vscale x 8 x bfloat> [[OP2:%.*]], i32 7)
// CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z25test_svmul_lane_bf16_idx7u14__SVBfloat16_tS_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x bfloat> @llvm.aarch64.sve.fmul.lane.nxv8bf16(<vscale x 8 x bfloat> [[OP1:%.*]], <vscale x 8 x bfloat> [[OP2:%.*]], i32 7)
// CPP-CHECK-NEXT:    ret <vscale x 8 x bfloat> [[TMP0]]
//
svbfloat16_t test_svmul_lane_bf16_idx7(svbfloat16_t op1, svbfloat16_t op2)
{
  return SVE_ACLE_FUNC(svmul_lane, _bf16, )(op1, op2, 7);
}

