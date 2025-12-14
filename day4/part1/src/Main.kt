import java.io.File

fun main() {
    val input = File("input.txt").readLines()
    val map = inputToMap(input)
    println(map)
    val surrounding = map.keys.map { surroundingRolls(it, map) }
    println(surrounding)
    val movable = countMovable(map, surrounding)
    println(movable)
}

fun inputToMap(input: List<String>): Map<Pair<Int, Int>, Char>{
    val out: MutableMap<Pair<Int, Int>, Char> = mutableMapOf()
    var y = 0
    for(str in input) {
        var x = 0
        for(c in str.toCharArray()){
            out[Pair(x, y)] = c
            x += 1
        }
        y += 1
    }

    return out
}

fun surroundingRolls(location: Pair<Int, Int>, map: Map<Pair<Int, Int>, Char>): Int{
    var surrounding = 0

    for(x in -1..1){
        for (y in -1..1){
            if (x == 0 && y == 0) continue
            val testLocation = Pair(location.first + x, location.second + y)
            if (map[testLocation] == '@') {
                surrounding += 1
            }
        }
    }

    return surrounding
}

fun countMovable(map: Map<Pair<Int, Int>, Char>, surrounding: List<Int>): Int{
    var index = 0
    var movable = 0
    for(i in map.values){
        if (i == '@' && surrounding[index] < 4) movable += 1
        index += 1
    }
    return movable
}