import SwiftUI

/// Spinning Pokéball used as a loading indicator on the detail screen.
struct PokeballLoadingView: View {
    @State private var isRotating = false
    
    var body: some View {
        VStack {
            Image("pokeball-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.pokeballSize, height: Constants.pokeballSize)
                .rotationEffect(.degrees(isRotating ? Constants.pokeballRotationAngle : 0))
                .animation(
                    .linear(duration: Constants.pokeballRotationDuration)
                    .repeatForever(autoreverses: false),
                    value: isRotating
                )
                .onAppear {
                    isRotating = true
                }
        }
    }
    
    private struct Constants {
        static let pokeballSize: CGFloat = 300
        static let pokeballRotationAngle: CGFloat = 360
        static let pokeballRotationDuration: TimeInterval = 1
    }
}


