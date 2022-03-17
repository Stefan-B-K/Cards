//

import SwiftUI

struct ToolbarButtonView: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass
  let modal: CardPickerModal
  
  
  func regularView(_ imageName: String, _ text: String) -> some View {
    VStack(spacing: 2) {
      Image(systemName: imageName)
        .font(.largeTitle)
      Text(text)
        .font(.system(size: 10))
    }
    .padding(.top, 5)
  }
  
  func compactView(_ imageName: String) -> some View {
    VStack(spacing: 2) {
      Image(systemName: imageName)
    }
    .padding(.top, 5)
  }
  
  
  var body: some View {
    if verticalSizeClass == .compact {
      compactView(modal.info.imageName)
    } else {
      regularView(modal.info.imageName, modal.info.text)
    }
  }
}

struct CardBottomToolbar: View {
  @EnvironmentObject var cardStore: CardStore
  @Binding var cardModal: CardPickerModal?
  
  var body: some View {
    HStack(alignment: .top){
      ForEach(CardPickerModal.allCases, id: \.self) { modal in
          Button {
            cardModal = modal
          } label: {
            ToolbarButtonView(modal: modal)
          }
          .padding(.trailing)
          .disabled(modal == .framePicker && (cardStore.selectedElement == nil || !(cardStore.selectedElement.self is ImageElement)))
        
      }
      
    }
  }
}

struct CardBottomToolbar_Previews: PreviewProvider {
  static var previews: some View {
    CardBottomToolbar(cardModal: .constant(.stickerPicker))
      .environmentObject(CardStore())
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
