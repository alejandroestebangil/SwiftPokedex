# Swift Pokédex
Native iOS Pokédex application built with Swift, using PokéAPI to display Pokémon information. The app follows clean architecture principles and modern iOS development practices.

## Features
- Browse and search through all Pokémon (up to Generation 9)
- View detailed Pokémon information including:
  - Official artwork
  - Base stats with visual representation
  - Type information with color coding
  - Height and weight
- Filter and sort capabilities:
  - Filter by generation
  - Sort by name or ID
  - Ascending/descending order
- Play Pokémon cries
- Offline support with CoreData persistence
- Clean, native iOS interface
- Comprehensive test coverage

## Architecture & Design Patterns
- Clean Architecture with clear separation of concerns
- MVVM + The Composable Architecture (TCA)
- Repository Pattern for data management
- Dependency Injection using Swift Dependencies
- Protocol-oriented programming
- Async/await for modern concurrency

## Tech Stack
- Swift
- SwiftUI for modern UI development
- [PokéAPI](https://pokeapi.co/) for Pokémon data
- URLSession for networking
- CoreData for local persistence
- AVFoundation for audio playback
- Tuist for project generation and management

## Dependencies
- [Swift Dependencies](https://github.com/pointfreeco/swift-dependencies) - Dependency management
- [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) - State management
- CoreData - Local storage
- AVFoundation - Audio playback

## Requirements
- iOS 16.0+
- Xcode 14.0+
- Swift 5.9+

## Installation
1. Clone the repository
```bash
git clone https://github.com/alejandroestebangil/SwiftPokedex.git
```
2. Install Tuist (if not already installed)
```bash
curl -Ls https://install.tuist.io | bash
```
3. Generate the Xcode project
```bash
tuist generate
```
4. Open the generated `SwiftPokedex.xcodeproj`

5. Build and run

## Project Structure
```
SwiftPokedex/
├── Sources/
│   ├── Data/
│   │   ├── DTOs/
│   │   ├── Network/
│   │   ├── LocalStorage/
│   │   └── Repositories/
│   ├── Dependencies/
│   ├── Domain/
│   │   ├── Entities/
│   │   ├── Interfaces/
│   │   └── UseCases/
│   └── Presentation/
│       ├── Components/
│       ├── DTOs/
│       ├── PokemonDetail/
│       └── PokeomnList/
└── Tests/
    ├── UseCases/
    └── Mocks/
```

## Credits
- Data provided by [PokéAPI](https://pokeapi.co/)
- Pokémon cries from [Pokémon Showdown](https://play.pokemonshowdown.com/)
- Pokémon is a trademark of Nintendo, Game Freak, and Creatures Inc.
