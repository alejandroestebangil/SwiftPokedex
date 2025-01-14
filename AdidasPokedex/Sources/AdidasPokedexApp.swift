import SwiftUI
import XCTestDynamicOverlay

@main
struct AdidasPokedexApp: App {
    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                PokemonListView()
            }
        }
    }
}
