// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MIDISequencer",
    platforms: [
        // Relevant platforms.
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13)
    ],
    products: [
        .library(name: "MIDISequencer", targets: ["MIDISequencer"])
    ],
    dependencies: [
        // It's a good thing to keep things relatively
        // independent, but add any dependencies here.
    ],
    targets: [
        .target(
            name: "MIDISequencer",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ]),
        .testTarget(name: "MIDISequencerTests", dependencies: ["MIDISequencer"]),
    ]
)
