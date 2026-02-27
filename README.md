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

<img width="240" height="524" alt="Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 16 01 49" src="https://github.com/user-attachments/assets/91c5a3ab-4fe5-40d7-9bfb-4b372ddde97c" />
<img width="240" height="524" alt="Simulator Screenshot - iPhone 17 Pro - 2026-02-27 at 16 02 11" src="https://github.com/user-attachments/assets/04185721-5a27-41c5-9654-e3063e6ab31b" />


## Architecture & Design Patterns
- Clean Architecture with clear separation of concerns
- The Composable Architecture (TCA)
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
cd SwiftPokedex
```
2. Install [mise](https://mise.jdx.dev/) (manages Tuist version)
```bash
brew install mise
mise install
```
3. Install dependencies and generate the Xcode project
```bash
mise exec -- tuist install
mise exec -- tuist generate
```
4. Open the generated `SwiftPokedex.xcworkspace` and build/run

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
│       └── PokemonList/
└── Tests/
    ├── UseCases/
    └── Mocks/
```

## Credits
- Data provided by [PokéAPI](https://pokeapi.co/)
- Pokémon cries from [Pokémon Showdown](https://play.pokemonshowdown.com/)
- Pokémon is a trademark of Nintendo, Game Freak, and Creatures Inc.
