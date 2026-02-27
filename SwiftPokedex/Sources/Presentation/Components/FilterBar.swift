import SwiftUI
import ComposableArchitecture

/// Horizontal bar with generation picker, sort type menu, and sort order toggle.
struct FilterBar: View {
    let store: StoreOf<PokemonListFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack(spacing: 16) {
                GenerationMenu(viewStore: viewStore)

                Spacer()

                SortTypeMenu(viewStore: viewStore)

                SortOrderButton(viewStore: viewStore)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .shadow(radius: 1)
        }
    }
}

/// Generation Menu
private struct GenerationMenu: View {
    let viewStore: ViewStoreOf<PokemonListFeature>

    var body: some View {
        Menu {
            ForEach(PokemonGeneration.allCases, id: \.self) { generation in
                Button(action: {
                    viewStore.send(.updateGeneration(generation))
                }) {
                    if generation == viewStore.selectedGeneration {
                        Label(FilterBar.getGenerationDisplayName(generation), systemImage: "checkmark")
                    } else {
                        Text(FilterBar.getGenerationDisplayName(generation))
                    }
                }
                .frame(width: 60)
            }
        } label: {
            Label(FilterBar.getGenerationDisplayName(viewStore.selectedGeneration), systemImage: "line.3.horizontal.decrease.circle")
                .foregroundColor(.primary)
        }
    }
}

/// Sort Type Menu
private struct SortTypeMenu: View {
    let viewStore: ViewStoreOf<PokemonListFeature>

    var body: some View {
        Menu {
            Button(action: { viewStore.send(.updateSortType(.id)) }) {
                if viewStore.selectedSortType == .id {
                    Label(FilterBar.getSortTypeDisplayName(.id), systemImage: "checkmark")
                } else {
                    Text(FilterBar.getSortTypeDisplayName(.id))
                }
            }

            Button(action: { viewStore.send(.updateSortType(.name)) }) {
                if viewStore.selectedSortType == .name {
                    Label(FilterBar.getSortTypeDisplayName(.name), systemImage: "checkmark")
                } else {
                    Text(FilterBar.getSortTypeDisplayName(.name))
                }
            }
        } label: {
            Label(FilterBar.getSortTypeDisplayName(viewStore.selectedSortType), systemImage: "slider.horizontal.3")
                .foregroundColor(.primary)
        }
    }
}

/// Sort Order Button
private struct SortOrderButton: View {
    let viewStore: ViewStoreOf<PokemonListFeature>

    var body: some View {
        Button(action: {
            viewStore.send(.toggleSortOrder)
        }) {
            Image(systemName: FilterBar.getSortOrderSystemImage(viewStore.selectedSortOrder))
                .foregroundColor(.primary)
        }
    }
}

/// Filters Display Names
extension FilterBar {
    static func getGenerationDisplayName(_ generation: PokemonGeneration) -> String {
        generation == .all ? "All Gens" : "Gen \(generation.rawValue)"
    }

    static func getSortTypeDisplayName(_ sortType: SortType) -> String {
        switch sortType {
        case .name:
            return "Name"
        case .id:
            return "Number"
        }
    }

    static func getSortOrderSystemImage(_ sortOrder: SortOrder) -> String {
        switch sortOrder {
        case .ascending:
            return "arrow.up"
        case .descending:
            return "arrow.down"
        }
    }
}
