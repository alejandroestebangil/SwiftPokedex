import Foundation

struct Pokemon: Identifiable, Codable, Equatable, Sendable {
    let id: Int
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "sprite_url"
    }
}
