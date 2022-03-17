//

import SwiftUI

struct CardElementView: View {
  let element: CardElement
  let selected: Bool
  
  var body: some View {
    if let element = element as? ImageElement{
      ImageElementView(element: element, selected: selected)
    }
    if let element = element as? TextElement {
      TextElementView(element: element)
    }
  }
}

struct ImageElementView: View {
  let element: ImageElement
  let selected: Bool
  
  var body: some View {
    if let frame = element.frame {
      element.image
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(frame)
        .overlay(frame.stroke(Settings.borderColor, lineWidth: selected ? Settings.borderWidth : 0))
    } else {
      element.image
        .resizable()
        .aspectRatio(contentMode: .fit)
        .border(Settings.borderColor, width: selected ? Settings.borderWidth : 0)
    }
  }
}

struct TextElementView: View {
  let element: TextElement
  
  var body: some View {
    if !element.text.isEmpty {
      Text(element.text)
        .font(.custom(element.textFont, size: 200))
        .foregroundColor(element.textColor)
        .scalableText()                                           // custom extension
    }
  }
}


struct CardElementView_Previews: PreviewProvider {
  static var previews: some View {
    CardElementView(element: initialElements[3], selected: false)
  }
}
