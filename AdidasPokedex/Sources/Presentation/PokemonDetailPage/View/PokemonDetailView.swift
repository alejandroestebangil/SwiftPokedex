import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonId: Int, repository: PokemonRepository) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(
            pokemonId: pokemonId,
            repository: repository
        ))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if let pokemon = viewModel.pokemonDetail {
                ScrollView {
                    VStack(spacing: 20) {
                        // Pokemon Image
                        AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        
                        // Pokemon Info
                        VStack(spacing: 16) {
                            // Name and Number
                            Text("#\(pokemon.id) - \(pokemon.name.capitalized)")
                                .font(.title)
                                .bold()
                            
                            // Types
                            HStack {
                                ForEach(pokemon.types, id: \.self) { type in
                                    Text(type.capitalized)
                                        .font(.subheadline)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(.gray.opacity(0.2))
                                        .cornerRadius(20)
                                }
                            }
                            
                            // Physical Characteristics
                            HStack(spacing: 40) {
                                VStack {
                                    Text("Height")
                                        .font(.subheadline)
                                    Text(String(format: "%.1f m", pokemon.height))
                                        .font(.headline)
                                }
                                
                                VStack {
                                    Text("Weight")
                                        .font(.subheadline)
                                    Text(String(format: "%.1f kg", pokemon.weight))
                                        .font(.headline)
                                }
                            }
                            .padding(.vertical)
                            
                            // Stats
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Base Stats")
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 4)
                                
                                ForEach(pokemon.baseStats, id: \.name) { stat in
                                    HStack {
                                        Text(stat.name.capitalized)
                                            .frame(width: 100, alignment: .leading)
                                        
                                        Text("\(stat.value)")
                                            .frame(width: 40, alignment: .trailing)
                                        
                                        ProgressView(value: Double(stat.value), total: 255)
                                            .tint(.blue)
                                    }
                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                        .padding()
                    }
                }
            }
        }
        .task {
            await viewModel.loadPokemonDetail()
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error")
        }
    }
}