import Dependencies

/// Plays a Pokémon's cry sound via the audio service.
protocol PlayPokemonCryUseCase {
    func execute(pokemonName: String) async throws
}

final class DefaultPlayPokemonCryUseCase: PlayPokemonCryUseCase {
    @Dependency(\.audioService) private var audioService

    func execute(pokemonName: String) async throws {
        try await audioService.playPokemonCry(for: pokemonName)
    }
}
