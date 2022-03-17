//

import SwiftUI

struct CardToolbarsVM: ViewModifier {
  
  @EnvironmentObject var cardStore: CardStore
  @Binding var currentModal: CardPickerModal?
  
  func body(content: Content) -> some View {
    ZStack {
      content
      VStack {
        HStack {
            Button(action: {
              cardStore.shouldScreenshot = true
              currentModal = .shareSheet
            }) {
              Image(systemName: "square.and.arrow.up")
            }
          
          Spacer()
          Button("Done") {
            withAnimation {
              cardStore.showAllCards = true
            }
          }
          .padding()
        }
        Spacer()
        HStack{
          CardBottomToolbar(cardModal: $currentModal)
        }
      }
    }
  }
}
