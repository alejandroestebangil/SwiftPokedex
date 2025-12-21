import ProjectDescription

let project = Project(
    name: "SwiftPokedex",
    targets: [
        .target(
            name: "SwiftPokedex",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.SwiftPokedex",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "SwiftPokedex/Sources",
                "SwiftPokedex/Resources",
            ],
            dependencies: [
                .sdk(name: "CoreData", type: .framework),
                .sdk(name: "AVFoundation", type: .framework),
                .external(name: "Dependencies"),
                .external(name: "ComposableArchitecture")
            ]
        ),
        .target(
            name: "SwiftPokedexTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.SwiftPokedexTests",
            infoPlist: .default,
            buildableFolders: [
                "SwiftPokedex/Tests"
            ],
            dependencies: [
                .target(name: "SwiftPokedex"),
                .external(name: "Dependencies"),
                .external(name: "ComposableArchitecture")
            ]
        ),
    ]
)
