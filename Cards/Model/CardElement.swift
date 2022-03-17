
import SwiftUI

protocol CardElement {
  var id: UUID { get }
  var transform: Transform { get set }
}

extension CardElement {
  func index(in array: [CardElement]) -> Int? {
    array.firstIndex { $0.id == id }
  }
}

struct ImageElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var image: Image
  var frame: AnyShape?
  var imageFilename: String?
}

extension ImageElement: Codable {
  
  enum CodingKeys: CodingKey {
    case transform, frame, imageFilename
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    transform = try container.decode(Transform.self, forKey: .transform)
    imageFilename = try container.decodeIfPresent(String.self, forKey: .imageFilename)
    if let imageFilename = imageFilename, let uiImage = UIImage.load(uuidString: imageFilename) {
      image = Image(uiImage: uiImage)
    } else {
      image = Image("error-image")
    }
    if let index = try container.decodeIfPresent(Int.self, forKey: .frame) {
      frame = Shapes.shapes[index]
    }
    
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(imageFilename, forKey: .imageFilename)
    
    if let index = Shapes.shapes.firstIndex(where: { $0 == frame } ) {
      try container.encode(index, forKey: .frame)
    }
  }
}

struct TextElement: CardElement {
  let id = UUID()
  var transform = Transform()
  var text = ""
  var textColor = Color.black
  var textFont = "San Fransisco"
}

extension TextElement: Codable {
  enum CodingKeys: CodingKey {
    case transform, text, textColor, textFont
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    transform = try container.decode(Transform.self, forKey: .transform)
    text = try container.decode(String.self, forKey: .text)
    let colorData = try container.decode([CGFloat].self, forKey: .textColor)
    textColor = Color.color(components: colorData)
    textFont = try container.decode(String.self, forKey: .textFont)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(transform, forKey: .transform)
    try container.encode(text, forKey: .text)
    let colroData = textColor.colorComponents()
    try container.encode(colroData, forKey: .textColor)
    try container.encode(textFont, forKey: .textFont)
  }
  
}
