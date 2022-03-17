//

import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var backgroundColor = Color.yellow
  var elements: [CardElement] = []
  var image: UIImage?
  var shareImage: UIImage?
  
  mutating func remove(_ element: CardElement) {
    if let element = element as? ImageElement {
      UIImage.remove(name: element.imageFilename)
    }
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
    save()
  }
  
  mutating func addElement(uiImage: UIImage, transform: Transform = Transform()) {
    let imageFilename = uiImage.save()
    let image = Image(uiImage: uiImage)
    let element = ImageElement(transform: transform, image: image, imageFilename: imageFilename)
    elements.append(element)
    save()
  }
  
  mutating func addElement(_ textElement: TextElement) {
    elements.append(textElement)
    save()
  }
  
  mutating func frameElement(_ element: CardElement?, frame: AnyShape) {
    if let element = element as? ImageElement,
       let index = element.index(in: elements) {
      var framedImage = element
      framedImage.frame = frame
      elements[index] = framedImage
    }
    save()
  }
  
  func save() {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let data = try encoder.encode(self)
      let fileName = "\(id).rwcard"
      if let url = FileManager.documentURL?.appendingPathComponent(fileName){
        try data.write(to: url)
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
}



extension Card: Codable {
  
  enum CodingKeys: CodingKey {
    case id, backgroundColor, imageElements, textElements
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    elements += try container.decode([ImageElement].self, forKey: .imageElements)
    elements += try container.decode([TextElement].self, forKey: .textElements)
    let colorData = try container.decode([CGFloat].self, forKey: .backgroundColor)
    backgroundColor = Color.color(components: colorData)
    
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.uuidString, forKey: .id)
    let imageElements: [ImageElement] = elements.compactMap { $0 as? ImageElement }
    try container.encode(imageElements, forKey: .imageElements)
    let textElements: [TextElement] = elements.compactMap { $0 as? TextElement }
    try container.encode(textElements, forKey: .textElements)
    try container.encode(backgroundColor.colorComponents(), forKey: .backgroundColor)
  }
  
}
