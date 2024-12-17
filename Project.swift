import ProjectDescription

let project = Project(
    name: "AdidasPokedex",
    targets: [
        .target(
            name: "AdidasPokedex",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.AdidasPokedex",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["AdidasPokedex/Sources/**"],
            resources: [
                "AdidasPokedex/Resources/**",
                "Sources/Data/LocalStorage/CoreData/Pokemon.xcdatamodeld"
            ],
            dependencies: [
                .sdk(name: "CoreData", type: .framework),
                .sdk(name: "AVFoundation", type: .framework)
            ]
        ),
        .target(
            name: "AdidasPokedexTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.AdidasPokedexTests",
            infoPlist: .default,
            sources: ["AdidasPokedex/Tests/**"],
            resources: [],
            dependencies: [.target(name: "AdidasPokedex")]
        ),
    ]
)
