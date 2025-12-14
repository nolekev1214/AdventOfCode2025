import java.io.File

fun main() {
    val answer = File("input.txt")
        .readLines()
        .map { it.toCharArray() }
        .map { findMaxJoltage(it) }
        .sum()

    println(answer)
}

fun findMaxJoltage(c: CharArray): Int {
    var firstMax = c[0].code - '0'.code
    var index = 0
    var secondMax = 0
    for(i in 1..<c.size - 1){
        val tmp = c[i].code - '0'.code
        if (tmp > firstMax) {
            firstMax = tmp
            index = i
        }
    }

    for(i in index+1..<c.size){
        val tmp = c[i].code - '0'.code
        if (tmp > secondMax) secondMax = tmp
    }

    val joltage = firstMax * 10 + secondMax
    return joltage
}