const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = try std.fs.cwd().openFile("input.txt", .{ .mode = .read_only });
    defer file.close();

    var buf: [2048]u8 = undefined;
    var reader = file.reader(&buf);

    var fresh = try std.ArrayList([]const u8).initCapacity(allocator, 99999);
    defer fresh.deinit(allocator);

    var ids = try std.ArrayList(u64).initCapacity(allocator, 2048);
    defer ids.deinit(allocator);

    var fresh_flag = true;
    while (try reader.interface.takeDelimiter('\n')) |line| {
        if (line.len == 0) {
            fresh_flag = false;
            continue;
        }
        if (fresh_flag) {
            try fresh.append(allocator, line);
            std.debug.print("Fresh Line: {s}\n", .{line});
        } else {
            try ids.append(allocator, try std.fmt.parseInt(u64, line, 10));
        }
    }
    var fresh_ids = try fresh_array_to_set(fresh, allocator);
    defer fresh_ids.deinit();

    var num_fresh: u64 = 0;
    for (ids.items) |value| {
        if (fresh_ids.contains(value)) {
            num_fresh += 1;
        }
    }

    std.debug.print("{}", .{num_fresh});
}

fn fresh_array_to_set(arr: std.ArrayList([]const u8), allocator: std.mem.Allocator) !std.HashMap(u64, void, std.hash_map.AutoContext(u64), 80) {
    var out = std.HashMap(u64, void, std.hash_map.AutoContext(u64), 80).init(allocator);

    for (arr.items) |value| {
        std.debug.print("Fresh Line to Process: {s}\n", .{value});
    }

    for (arr.items) |value| {
        std.debug.print("Fresh Line to Process: {s}\n", .{value});

        var it = std.mem.tokenizeAny(u8, value, "-");

        const begin_str = it.next().?;
        std.debug.print("Begin: {s} ", .{begin_str});
        const end_str = it.next().?;
        std.debug.print("End: {s}\n", .{end_str});

        const begin = try std.fmt.parseInt(u64, begin_str, 10);
        const end = try std.fmt.parseInt(u64, end_str, 10);

        for (begin..end + 1) |fresh_id| {
            try out.put(fresh_id, {});
        }
    }

    return out;
}
