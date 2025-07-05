// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MandelbrotApp",
    platforms: [.macOS(.v11)],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "MandelbrotApp",
            dependencies: []
        )
    ]
)
