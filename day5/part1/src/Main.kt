import java.io.File

fun main() {
    val input = File("input.txt").readLines()
    val splitAt = input.indexOf("")
    val ranges = input.subList(0, splitAt)
    val items = input.subList(splitAt + 1, input.size).map { it.toLong() }

    val fresh = rangesStrToSet(ranges)
    val numFresh = items.count { isFresh(it, fresh) }
    println(numFresh)
}

fun rangesStrToSet(ranges: List<String>): Set<Long> {
    val out = mutableSetOf<Long>()
    for(range in ranges) {
        val values = range.split("-")
        val begin = values[0].toLong()
        val end = values[1].toLong()
        for(i in begin..end) {
            out.add(i)
        }
    }

    return out
}

fun isFresh(item: Long, fresh: Set<Long>): Boolean {
    return item in fresh
}