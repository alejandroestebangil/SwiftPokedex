import SwiftUI

/// Blue banner at the top of the list with Pokédex logo. Tapping scrolls to top.
struct PokemonHeader: View {
    let onTap: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(Color(.systemBlue))
            .edgesIgnoringSafeArea(.horizontal)
            .frame(height: Constants.height)
            .overlay(
                HStack(spacing: Constants.imageSpacing) {
                    Image("pokedex-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Constants.pokedexHeight)
                    
                    Image("pokeball-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.pokeballSize, height: Constants.pokeballSize)
                }
            )
            .shadow(radius: 3)
            .onTapGesture(perform: onTap)
    }
    
    
    private struct Constants {
        static let height: CGFloat = 90
        static let imageSpacing: CGFloat = 12
        static let pokedexHeight: CGFloat = 80
        static let pokeballSize: CGFloat = 70
    }
}
