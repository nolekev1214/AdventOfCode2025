import java.io.File

fun main() {
    val input = File("input.txt").readLines()
    var map = inputToMap(input)

    var moved = 0
    var movedPrevious = -1
    while (movedPrevious != 0) {
        val surrounding = map.keys.map { surroundingRolls(it, map) }
        val (_map, _movedPrevious) = movableRolls(map, surrounding)
        movedPrevious = _movedPrevious
        map = _map
        moved += movedPrevious
    }
    println(moved)
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

fun movableRolls(map: Map<Pair<Int, Int>, Char>, surrounding: List<Int>): Pair<Map<Pair<Int, Int>, Char>, Int>{
    val copy = map.toMutableMap()
    var index = 0
    var movable = 0
    for(i in map){
        if (i.value == '@' && surrounding[index] < 4) {
            movable += 1
            copy[i.key] = '.'
        }
        index += 1
    }
    return Pair(copy, movable)
}