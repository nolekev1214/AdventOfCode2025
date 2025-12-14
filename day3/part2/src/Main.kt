import java.io.File
import java.math.BigInteger

fun main() {
    val answer = File("input.txt")
        .readLines()
        .map{ it.toCharArray() }
        .map{ maxJoltage(it) }
        .reduce(BigInteger::add)

    println(answer)
}

fun maxJoltage(c: CharArray): BigInteger {
    var maxJoltage: BigInteger = BigInteger.ZERO
    var digitsToFind = 12
    var index = 0

    while(digitsToFind > 0) {
        digitsToFind -= 1

        var max = 0
        for (i in index..<c.size - digitsToFind){
            val tmp = c[i].code - '0'.code
            if (tmp > max) {
                max = tmp
                index = i
            }
        }

        maxJoltage *= BigInteger.valueOf(10)
        maxJoltage += BigInteger.valueOf(max.toLong())
        index += 1
    }
    return maxJoltage
}