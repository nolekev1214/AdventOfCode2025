const std = @import("std");

const Dial = struct {
    pointer: i32,
    counter: i32,
};

fn dial_rotate_right(dial: *Dial, rotation: i32) void {
    dial.pointer += rotation;
    while (dial.pointer >= 100) {
        dial.pointer -= 100;
    }
    if (dial.pointer == 0) {
        dial.counter += 1;
    }
}

fn dial_rotate_left(dial: *Dial, rotation: i32) void {
    dial.pointer -= rotation;
    while (dial.pointer < 0) {
        dial.pointer += 100;
    }
    if (dial.pointer == 0) {
        dial.counter += 1;
    }
}

fn dial_rotate(dial: *Dial, str: []const u8) !void {
    const rotation = try std.fmt.parseInt(i32, str[1..], 10);

    if (str[0] == 'L') {
        dial_rotate_left(dial, rotation);
    } else if (str[0] == 'R') {
        dial_rotate_right(dial, rotation);
    }
}

pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{ .mode = .read_only });
    defer file.close();

    var buf: [1024]u8 = undefined;
    var reader = file.reader(&buf);

    var dial = Dial{ .counter = 0, .pointer = 50 };
    while (try reader.interface.takeDelimiter('\n')) |line| {
        std.debug.print("Line: {s}\n", .{line});
        try dial_rotate(&dial, line);
        std.debug.print("Dial {}\n", .{dial});
    }
}

test "dial_rotate_right_without_counter_increment" {
    // Arrange
    var dial = Dial{ .pointer = 50, .counter = 0 };

    // Act
    dial_rotate_right(&dial, 23);

    // Assert
    try std.testing.expectEqual(73, dial.pointer);
}

test "dial_rotate_right_with_counter_increment" {
    // Arrange
    var dial = Dial{ .pointer = 50, .counter = 0 };

    // Act
    dial_rotate_right(&dial, 50);

    // Assert
    try std.testing.expectEqual(Dial{ .pointer = 0, .counter = 1 }, dial);
}

test "dial_rotate_left_without_counter_increment" {
    // Arrange
    var dial = Dial{ .pointer = 50, .counter = 0 };

    // Act
    dial_rotate_left(&dial, 23);

    // Assert
    try std.testing.expectEqual(27, dial.pointer);
}

test "dial_rotate_left_with_counter_increment" {
    // Arrange
    var dial = Dial{ .pointer = 50, .counter = 0 };

    // Act
    dial_rotate_left(&dial, 50);

    // Assert
    try std.testing.expectEqual(Dial{ .pointer = 0, .counter = 1 }, dial);
}

test "integration_manual_dial_moves_match_example" {
    // Arrange
    var dial = Dial{ .pointer = 50, .counter = 0 };

    // Act & Assert
    try dial_rotate(&dial, "L68");
    try std.testing.expectEqual(Dial{ .counter = 0, .pointer = 82 }, dial);
    try dial_rotate(&dial, "L30");
    try std.testing.expectEqual(Dial{ .counter = 0, .pointer = 52 }, dial);
    try dial_rotate(&dial, "R48");
    try std.testing.expectEqual(Dial{ .counter = 1, .pointer = 0 }, dial);
    try dial_rotate(&dial, "L5");
    try std.testing.expectEqual(Dial{ .counter = 1, .pointer = 95 }, dial);
    try dial_rotate(&dial, "R60");
    try std.testing.expectEqual(Dial{ .counter = 1, .pointer = 55 }, dial);
    try dial_rotate(&dial, "L55");
    try std.testing.expectEqual(Dial{ .counter = 2, .pointer = 0 }, dial);
    try dial_rotate(&dial, "L1");
    try std.testing.expectEqual(Dial{ .counter = 2, .pointer = 99 }, dial);
    try dial_rotate(&dial, "L99");
    try std.testing.expectEqual(Dial{ .counter = 3, .pointer = 0 }, dial);
    try dial_rotate(&dial, "R14");
    try std.testing.expectEqual(Dial{ .counter = 3, .pointer = 14 }, dial);
    try dial_rotate(&dial, "L82");
    try std.testing.expectEqual(Dial{ .counter = 3, .pointer = 32 }, dial);
}
