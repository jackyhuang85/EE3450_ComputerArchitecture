import chisel3._
import chisel3.util._

class HammingCode extends Module {
  val io = IO( new Bundle {
    val in     = Input(UInt(4.W))
    val enable = Input(Bool())
    val out    = Output(UInt(7.W))
    val valid  = Output(Bool())
  })
  val p3 = io.in(3) ^ io.in(2) ^ io.in(1)
  val p2 = io.in(3) ^ io.in(2) ^ io.in(0)
  val p1 = io.in(3) ^ io.in(1) ^ io.in(0)
  val hamming = Reg(UInt(7.W))
  val valid_reg = Reg(UInt())
  when(io.enable) {
    hamming := Cat(io.in(3,1), p3, io.in(0), p2, p1)
    valid_reg := 1.U
  }
  .otherwise {
    hamming := hamming
    valid_reg := 0.U
  }

  io.out := hamming
  io.valid := valid_reg

}

