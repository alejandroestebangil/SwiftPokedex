import AVFoundation

protocol PokemonAudioServiceProtocol {
    func playPokemonCry(for name: String) async throws
}

class PokemonAudioService: PokemonAudioServiceProtocol {
    private var audioPlayer: AVAudioPlayer?
    
    func playPokemonCry(for name: String) async throws {
        let formattedName = name.lowercased()

        guard let url = URL(string: "https://play.pokemonshowdown.com/audio/cries/\(formattedName).mp3") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        audioPlayer = try AVAudioPlayer(data: data)
        audioPlayer?.play()
    }
}
