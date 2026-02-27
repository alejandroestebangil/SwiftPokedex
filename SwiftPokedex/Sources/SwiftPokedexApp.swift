import SwiftUI
import ComposableArchitecture
import XCTestDynamicOverlay

@main
struct SwiftPokedexApp: App {
    /// Root TCA store — lives for the app's lifetime.
    let store = Store(initialState: PokemonListFeature.State()) {
        PokemonListFeature()
    }

    var body: some Scene {
        WindowGroup {
            /// Skip rendering during unit tests to avoid side-effects.
            if !_XCTIsTesting {
                PokemonListView(store: store)
            }
        }
    }
}
