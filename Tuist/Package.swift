// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        productTypes: [
            "SwiftDependencies": .framework
        ]
    )
#endif

let package = Package(
    name: "AdidasPokedex",
    dependencies: [
        // Add your own dependencies here:
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0")
    ]
)
