const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig-playground",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibC();

    { // qml_playground
        const path = "../qml_playground";
        exe.addIncludePath(.{ .path = path });
        // exe.addObjectFile(.{ .path = path ++ "/cmake-build-debug/qml_playground.a" });

        b.installBinFile(path ++ "/cmake-build-debug/qml_playground.dll", "qml_playground.dll");
        exe.addLibraryPath(.{ .path = path ++ "/cmake-build-debug" });
        exe.linkSystemLibrary("qml_playground");
    }
    {
        exe.addLibraryPath(.{ .path = "C:/Qt/6.7.1/mingw_64/lib" });
        exe.addLibraryPath(.{ .path = "C:/Qt/6.7.1/mingw_64/bin" });

        // exe.linkSystemLibrary("Qt6Widgets");
    }

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
