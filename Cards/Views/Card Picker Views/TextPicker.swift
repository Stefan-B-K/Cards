//

import SwiftUI

struct TextPicker: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var textElement: TextElement
  
    var body: some View {
      VStack {
        TextField("Въведете текст", text: $textElement.text)
          .font(.custom(textElement.textFont, size: 30))
          .foregroundColor(textElement.textColor)
          .onSubmit {
            presentationMode.wrappedValue.dismiss()
        }
        TextView(
          font: $textElement.textFont,
          color: $textElement.textColor)
      }
}
}

struct TextPicker_Previews: PreviewProvider {
  @State static var textElement = TextElement()
    static var previews: some View {
      TextPicker(textElement: $textElement)
    }
}
