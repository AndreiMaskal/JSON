import Foundation

public struct Cards: Decodable {
    let cards: [setCard]
}

struct setCard: Decodable {
    let name: String
    let manaCost: String?
    let cmc: Double?
    let type: String?
    let types: [String]?
    let rarity: String?
    let set: String?
}
