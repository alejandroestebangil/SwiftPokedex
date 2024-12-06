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
            // Generation Choose
            Menu {
                ForEach(PokemonGeneration.allCases, id: \.self) { generation in
                    Button(action: {
                        viewModel.updateGeneration(generation)
                    }) {
                        if generation == viewModel.selectedGeneration {
                            Label(generation.displayName, systemImage: "checkmark")
                        } else {
                            Text(generation.displayName)
                        }
                    }
                    .frame(width: 60)
                }
            } label: {
                Label(viewModel.selectedGeneration.displayName, systemImage: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            // Sort Type Menu
            Menu {
                Button(action: { viewModel.updateSortType(.id) }) {
                    if viewModel.selectedSortType == .id {
                        Label("Number", systemImage: "checkmark")
                    } else {
                        Text("Number")
                    }
                }
                
                Button(action: { viewModel.updateSortType(.name) }) {
                    if viewModel.selectedSortType == .name {
                        Label("Name", systemImage: "checkmark")
                    } else {
                        Text("Name")
                    }
                }
            } label: {
                Label(viewModel.selectedSortType.displayName, systemImage: "slider.horizontal.3")
                    .foregroundColor(.primary)
            }
            
            // Sort Order Button
            Button(action: {
                viewModel.toggleSortOrder()
            }) {
                Image(systemName: viewModel.selectedSortOrder.systemImage)
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .shadow(radius: 1)
    }
}
