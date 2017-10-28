;buildInfoPackage: chisel3, version: 3.0-SNAPSHOT, scalaVersion: 2.11.11, sbtVersion: 0.13.16, builtAtString: 2017-10-06 20:55:20.367, builtAtMillis: 1507323320367
circuit HammingCode : 
  module HammingCode : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip in : UInt<4>, flip enable : UInt<1>, out : UInt<7>, valid : UInt<1>}
    
    clock is invalid
    reset is invalid
    io is invalid
    node _T_6 = bits(io.in, 3, 3) @[HammingCode.scala 11:17]
    node _T_7 = bits(io.in, 2, 2) @[HammingCode.scala 11:28]
    node _T_8 = xor(_T_6, _T_7) @[HammingCode.scala 11:21]
    node _T_9 = bits(io.in, 1, 1) @[HammingCode.scala 11:39]
    node p3 = xor(_T_8, _T_9) @[HammingCode.scala 11:32]
    node _T_10 = bits(io.in, 3, 3) @[HammingCode.scala 12:17]
    node _T_11 = bits(io.in, 2, 2) @[HammingCode.scala 12:28]
    node _T_12 = xor(_T_10, _T_11) @[HammingCode.scala 12:21]
    node _T_13 = bits(io.in, 0, 0) @[HammingCode.scala 12:39]
    node p2 = xor(_T_12, _T_13) @[HammingCode.scala 12:32]
    node _T_14 = bits(io.in, 3, 3) @[HammingCode.scala 13:17]
    node _T_15 = bits(io.in, 1, 1) @[HammingCode.scala 13:28]
    node _T_16 = xor(_T_14, _T_15) @[HammingCode.scala 13:21]
    node _T_17 = bits(io.in, 0, 0) @[HammingCode.scala 13:39]
    node p1 = xor(_T_16, _T_17) @[HammingCode.scala 13:32]
    reg hamming : UInt<7>, clock @[HammingCode.scala 14:20]
    reg valid_reg : UInt, clock @[HammingCode.scala 15:22]
    when io.enable : @[HammingCode.scala 16:19]
      node _T_20 = bits(io.in, 3, 1) @[HammingCode.scala 17:25]
      node _T_21 = bits(io.in, 0, 0) @[HammingCode.scala 17:41]
      node _T_22 = cat(p2, p1) @[Cat.scala 30:58]
      node _T_23 = cat(_T_20, p3) @[Cat.scala 30:58]
      node _T_24 = cat(_T_23, _T_21) @[Cat.scala 30:58]
      node _T_25 = cat(_T_24, _T_22) @[Cat.scala 30:58]
      hamming <= _T_25 @[HammingCode.scala 17:13]
      valid_reg <= UInt<1>("h01") @[HammingCode.scala 18:15]
      skip @[HammingCode.scala 16:19]
    else : @[HammingCode.scala 20:14]
      hamming <= hamming @[HammingCode.scala 21:13]
      valid_reg <= UInt<1>("h00") @[HammingCode.scala 22:15]
      skip @[HammingCode.scala 20:14]
    io.out <= hamming @[HammingCode.scala 25:10]
    io.valid <= valid_reg @[HammingCode.scala 26:12]
    
