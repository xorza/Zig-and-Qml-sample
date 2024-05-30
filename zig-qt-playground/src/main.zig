const q = @cImport({
    @cInclude("library.h");
});

const std = @import("std");
const assert = @import("std").debug.assert;

pub fn main() !void {
    _ = q.run();

    std.debug.print("Hello, world!\n", .{});
}
