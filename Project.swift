import ProjectDescription

let project = Project(
    name: "SwiftPokedex",
    targets: [
        .target(
            name: "SwiftPokedex",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SwiftPokedex",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["SwiftPokedex/Sources/**"],
            resources: [
                "SwiftPokedex/Resources/**",
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
            bundleId: "io.tuist.SwiftPokedexTests",
            infoPlist: .default,
            sources: ["SwiftPokedex/Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "SwiftPokedex"),
                .external(name: "Dependencies"),
                .external(name: "ComposableArchitecture")
            ]
        ),
    ]
)
