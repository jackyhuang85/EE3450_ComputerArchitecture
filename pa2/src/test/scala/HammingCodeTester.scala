import chisel3._
import chisel3.util._
import chisel3.iotesters.{PeekPokeTester, Driver, ChiselFlatSpec}


class HammingCodeTests(c: HammingCode) extends PeekPokeTester(c) {
    val outputs = List(0, 7, 25, 30, 42, 45, 51, 52, 75, 76, 82, 85, 97, 102, 120, 127)
    for (num <- 0 until 16){
        var cnt = 0
        poke(c.io.in, num)
        poke(c.io.enable, 1)
        step(1)
        poke(c.io.enable, 0)
        poke(c.io.in, 0)
        step(1)

        expect(c.io.out, outputs(num))
    }
}

class HammingCodeSpec extends ChiselFlatSpec {
    behavior of "HammingCodeSpec"
    it should "compute Hamming code parity bits excellently" in {
          Driver.execute(Array("-fiwv"), () => new HammingCode) { c =>
                new HammingCodeTests(c)
              } should be (true)

    }

}
