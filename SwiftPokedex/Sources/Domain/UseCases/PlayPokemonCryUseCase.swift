import Dependencies

protocol PlayPokemonCryUseCase {
    func execute(pokemonName: String) async throws
}

final class DefaultPlayPokemonCryUseCase: PlayPokemonCryUseCase {
    @Dependency(\.audioService) private var audioService

    func execute(pokemonName: String) async throws {
        try await audioService.playPokemonCry(for: pokemonName)
    }
}
