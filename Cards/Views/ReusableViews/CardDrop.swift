//

import SwiftUI

struct CardDrop: DropDelegate {
  @Binding var card: Card
  var size: CGSize = .zero
  var frame: CGRect = .zero
  
  func performDrop(info: DropInfo) -> Bool {
    let itemProviders = info.itemProviders(for: [.image])
    let offset = calculateOffset(location: info.location)
    let transform = Transform(offset: offset)
    loadAddImages(from: itemProviders, to: $card, transform: transform)
    return true
  }
  
  func calculateOffset(location: CGPoint) -> CGSize {
    guard size.width > 0 && size.height > 0 else { return .zero }
    let leftMargin = (frame.width - size.width) * 0.5 + frame.origin.x
    let topMargin = (frame.height - size.height) * 0.5 + frame.origin.y
    var cardLocation = CGPoint(x: location.x - leftMargin, y: location.y - topMargin)
    cardLocation.x = cardLocation.x / size.width * Settings.cardSize.width
    cardLocation.y = cardLocation.y / size.height * Settings.cardSize.height
    let offset = CGSize(
      width: cardLocation.x - Settings.cardSize.width * 0.5,
      height: cardLocation.y - Settings.cardSize.height * 0.5)
    return offset
  }
  
  
}

func loadAddImages(from itemProviders: [NSItemProvider], to card: Binding<Card>, transform: Transform = Transform()) {
  for item in itemProviders {
    if item.canLoadObject(ofClass: UIImage.self) {
      item.loadObject(ofClass: UIImage.self) { image, error in
        if let error = error {
          print("Грешка!", error.localizedDescription)
        }
        if let image = image as? UIImage {
          DispatchQueue.main.async {
            card.wrappedValue.addElement(uiImage: image, transform: transform)
          }
        }
      }
    }
  }
}


