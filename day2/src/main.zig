const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().openFile("input.txt", .{ .mode = .read_only });
    defer file.close();

    var buf: [4096]u8 = undefined;
    var reader = file.reader(&buf);

    while (try reader.interface.takeDelimiter(',')) |range| {
        const out = try range_from_string(range);
        try check_numbers_in_range(out.begin, out.end);
    }
}

fn range_from_string(str: []const u8) !struct { begin: u64, end: u64 } {
    var it = std.mem.tokenizeAny(u8, str, "-");
    const begin = it.next().?;
    var end = it.next().?;
    if (end[end.len - 1] == '\n') {
        end = end[0 .. end.len - 1];
    }
    const begin2 = try std.fmt.parseInt(u64, begin, 10);
    const end2 = try std.fmt.parseInt(u64, end, 10);
    return .{ .begin = begin2, .end = end2 };
}

fn check_valid_id(str: []const u8) !bool {
    if (str.len % 2 == 1) {
        return true;
    }

    const first_half = str[0 .. str.len / 2];
    const second_half = str[str.len / 2 ..];
    if (std.mem.eql(u8, first_half, second_half)) {
        return false;
    }
    return true;
}

fn check_numbers_in_range(begin: u64, end: u64) !void {
    var _begin = begin;
    while (_begin <= end) {
        var buf: [1024]u8 = undefined;
        const str = try std.fmt.bufPrint(&buf, "{}", .{_begin});
        if (!try check_valid_id(str)) {
            std.debug.print("{}\n", .{_begin});
        }
        _begin += 1;
    }
}
