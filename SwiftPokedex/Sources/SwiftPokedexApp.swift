import SwiftUI
import XCTestDynamicOverlay

@main
struct SwiftPokedexApp: App {
    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                PokemonListView()
            }
        }
    }
}
