// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "RepeatCommandLineTool",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "repeat", targets: ["RepeatCommandLineTool"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "RepeatCommandLineTool",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "RepeatCommandLineToolTests",
            dependencies: ["RepeatCommandLineTool"]),
    ]
)

// IMPORTANT: enable the following function call if you encounter the error
//    `dyld: Library not loaded: @rpath/libswift_Concurrency.dylib`

//hookInternalSwiftConcurrency()

func hookInternalSwiftConcurrency() {
    let isFromTerminal = ProcessInfo.processInfo.environment.values.contains("/usr/bin/swift")
    if !isFromTerminal {
        package.targets.first?.addLinkerSettingUnsafeFlagRunpathSearchPath()
    }
}

extension PackageDescription.Target {
    func addLinkerSettingUnsafeFlagRunpathSearchPath() {
        linkerSettings = [linkerSetting]
    }

    private var linkerSetting: LinkerSetting {
        guard let xcodeFolder = Executable("/usr/bin/xcode-select")("-p") else {
            fatalError("Could not run `xcode-select -p`")
        }

        let toolchainFolder = "\(xcodeFolder.trimmed)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift-5.5/macosx"

        return .unsafeFlags(["-rpath", toolchainFolder])
    }
}

extension String {
    var trimmed: String { trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
}

private struct Executable {
    private let url: URL

    init(_ filePath: String) {
        url = URL(fileURLWithPath: filePath)
    }

    func callAsFunction(_ arguments: String...) -> String? {
        let process = Process()
        process.executableURL = url
        process.arguments = arguments

        let stdout = Pipe()
        process.standardOutput = stdout

        process.launch()
        process.waitUntilExit()

        return stdout.readStringToEndOfFile()
    }
}

extension Pipe {
    func readStringToEndOfFile() -> String? {
        let data: Data
        if #available(OSX 10.15.4, *) {
            data = (try? fileHandleForReading.readToEnd()) ?? Data()
        } else {
            data = fileHandleForReading.readDataToEndOfFile()
        }

        return String(data: data, encoding: .utf8)
    }
}

