//

import SwiftUI
import PencilKit

struct FramePicker: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var cardStore: CardStore
  @Binding var card: Card
  
  private let columns = [GridItem(.adaptive(minimum: 120), spacing: 10)]
  private let strokeStyle = StrokeStyle(lineWidth: 5, lineJoin: .round)
  
  var body: some View {
    ScrollView{
      LazyVGrid(columns: columns) {
        ForEach(0..<Shapes.shapes.count) { index in
          let shape = Shapes.shapes[index]
          shape
            .stroke(Color.primary, style: strokeStyle)
            .background(shape.fill(Color.secondary))            // за селектиране не само по контура
            .frame(width: 100, height: 130)
            .padding()
            .onTapGesture {
              card.frameElement(cardStore.selectedElement , frame: shape)
              presentationMode.wrappedValue.dismiss()
            }
        }
      }
    }
    .padding(5)
  }
}

struct FramePicker_Previews: PreviewProvider {
  static var previews: some View {
    FramePicker(card: .constant(Card()))
  }
}
