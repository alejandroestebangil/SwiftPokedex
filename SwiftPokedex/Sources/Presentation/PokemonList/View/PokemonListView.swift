import SwiftUI
import ComposableArchitecture

struct PokemonListView: View {
    let store: StoreOf<PokemonListFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                ScrollViewReader { proxy in
                    VStack(spacing: 0) {
                        PokemonHeader {
                            withAnimation {
                                proxy.scrollTo("top", anchor: .top)
                            }
                        }

                        FilterBar(store: store)

                        Group {
                            if viewStore.isLoading {
                                LoadingView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                pokemonList(viewStore: viewStore)
                                    .navigationBarTitleDisplayMode(.inline)
                            }
                        }
                        .task { viewStore.send(.onAppear) }
                        .alert(
                            "Error",
                            isPresented: viewStore.binding(
                                get: { $0.error != nil },
                                send: .dismissError
                            )
                        ) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text(viewStore.error ?? "Unknown error")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .navigationDestination(
                        store: store.scope(state: \.$destination, action: \.destination)
                    ) { detailStore in
                        PokemonDetailView(store: detailStore)
                    }
                }
            }
        }
    }

    private func pokemonList(viewStore: ViewStoreOf<PokemonListFeature>) -> some View {
        List {
            ForEach(viewStore.filteredPokemons) { pokemon in
                Button {
                    viewStore.send(.pokemonTapped(id: pokemon.id))
                } label: {
                    PokemonRowView(pokemon: pokemon)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .id(viewStore.filteredPokemons.first?.id == pokemon.id ? "top" : nil)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading Pokémon...")
        }
    }
}
