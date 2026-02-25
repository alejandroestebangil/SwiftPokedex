import SwiftUI
import ComposableArchitecture
import XCTestDynamicOverlay

@main
struct SwiftPokedexApp: App {
    let store = Store(initialState: PokemonListFeature.State()) {
        PokemonListFeature()
    }

    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                PokemonListView(store: store)
            }
        }
    }
}
