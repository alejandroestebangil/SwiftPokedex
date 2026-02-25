import SwiftUI

struct PokemonAsyncImage: View {
    let url: String?
    let size: CGFloat
    static let imageOpacity: Double = 0.3
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image("pokemon-not-avaliable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(PokemonAsyncImage.imageOpacity)
            @unknown default:
                Image("pokemon-not-avaliable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(PokemonAsyncImage.imageOpacity)
            }
        }
        .frame(width: size, height: size)
    }
}
