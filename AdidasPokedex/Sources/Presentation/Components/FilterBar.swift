//
//  FilterBar.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 6/12/24.
//

import SwiftUI

struct FilterBar: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            GenerationMenu(viewModel: viewModel)
            
            Spacer()
            
            SortTypeMenu(viewModel: viewModel)
            
            SortOrderButton(viewModel: viewModel)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .shadow(radius: 1)
    }
}

/// Generation Menu
private struct GenerationMenu: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        Menu {
            ForEach(PokemonGeneration.allCases, id: \.self) { generation in
                Button(action: {
                    viewModel.updateGeneration(generation)
                }) {
                    if generation == viewModel.selectedGeneration {
                        Label(FilterBar.getGenerationDisplayName(generation), systemImage: "checkmark")
                    } else {
                        Text(FilterBar.getGenerationDisplayName(generation))
                    }
                }
                .frame(width: 60)
            }
        } label: {
            Label(FilterBar.getGenerationDisplayName(viewModel.selectedGeneration), systemImage: "line.3.horizontal.decrease.circle")
                .foregroundColor(.primary)
        }
    }
}

/// Sort Type Menu
private struct SortTypeMenu: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        Menu {
            Button(action: { viewModel.updateSortType(.id) }) {
                if viewModel.selectedSortType == .id {
                    Label(FilterBar.getSortTypeDisplayName(.id), systemImage: "checkmark")
                } else {
                    Text(FilterBar.getSortTypeDisplayName(.id))
                }
            }
            
            Button(action: { viewModel.updateSortType(.name) }) {
                if viewModel.selectedSortType == .name {
                    Label(FilterBar.getSortTypeDisplayName(.name), systemImage: "checkmark")
                } else {
                    Text(FilterBar.getSortTypeDisplayName(.name))
                }
            }
        } label: {
            Label(FilterBar.getSortTypeDisplayName(viewModel.selectedSortType), systemImage: "slider.horizontal.3")
                .foregroundColor(.primary)
        }
    }
}

/// Sort Order Button
private struct SortOrderButton: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleSortOrder()
        }) {
            Image(systemName: FilterBar.getSortOrderSystemImage(viewModel.selectedSortOrder))
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
