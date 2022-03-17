
import SwiftUI

enum CardListState {
  case list, carousel
}

final class CardStore: ObservableObject {
  @Published var cards: [Card] = []
  @Published var showAllCards = true {
    didSet {
      if showAllCards {
        selectedCard = nil
      }
    }
  }
  @Published var selectedElement: CardElement?
  @Published var cardListState: CardListState = .list
  
  var shouldScreenshot = false    // For sharing the card with a screenshot - see `RenderableView`
  
  var selectedCard: Card? {
    didSet {
      if selectedCard == nil {
        selectedElement = nil
      }
    }
  }
  
  init(defaultData: Bool = false) {
      cards = defaultData ? initialCards : load()                                        // PreviewData
  }
  
  convenience init(card: Card) {
    self.init()
    showAllCards = false
    selectedCard = card
    selectedElement = nil
  }
  
  func index(for card: Card) -> Int? {
    cards.firstIndex { $0.id == card.id }
  }
  
  func remove(_ card: Card) {
    if let index = index(for: card) {
      for element in cards[index].elements {
        cards[index].remove(element)
      }
      UIImage.remove(name: card.id.uuidString)
      if let filepath = FileManager.documentURL?.absoluteURL.appendingPathComponent("\(card.id.uuidString).rwcard") {
        try? FileManager.default.removeItem(at: filepath)
      }
      cards.remove(at: index)
    }
  }
  
  func addCard() -> Card {
    let card = Card(backgroundColor: Color.random())
    cards.append(card)
    card.save()
    return card
  }
}


extension CardStore {
  
  func load() -> [Card] {
    var cards = [Card]()
    guard let path = FileManager.documentURL?.path,
            let enumerator = FileManager.default.enumerator(atPath: path),
          let files = enumerator.allObjects as? [String] else {
            return cards
          }
    let cardFiles = files.filter { $0.contains(".rwcard") }
    for cardFile in cardFiles {
      do {
        let path = path + "/" + cardFile
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let card = try JSONDecoder().decode(Card.self, from: data)
        cards.append(card)
      } catch {
        print(error.localizedDescription)
      }
    }
    return cards
  }
  
}
