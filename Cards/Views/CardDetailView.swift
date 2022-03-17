//

import SwiftUI
import PencilKit

struct CardDetailView: View {
  @EnvironmentObject var cardStore: CardStore
  @Environment(\.scenePhase) private var scenePhase
  @State private var currentModal: CardPickerModal?
  @State private var pencilImage: UIImage?
  @State private var shape: AnyShape?
  @State private var textElement = TextElement()
  @Binding var card: Card
  
  func bindingTransform(for element: CardElement) -> Binding<Transform> {
    guard let index = element.index(in: card.elements) else {
      fatalError("Element does not exist")
    }
    return $card.elements[index].transform
  }
  
  func calculateSize(_ size: CGSize) -> CGSize {
    var newSize = size
    let ratio =
    Settings.cardSize.width / Settings.cardSize.height
    
    if size.width < size.height {
      newSize.height = min(size.height, newSize.width / ratio)
      newSize.width = min(size.width, newSize.height * ratio)
    } else {
      newSize.width = min(size.width, newSize.height * ratio)
      newSize.height = min(size.height, newSize.width / ratio)
    }
    return newSize
  }
  
  func calculateScale(_ size: CGSize) -> CGFloat {
    let newSize = calculateSize(size)
    return newSize.width / Settings.cardSize.width
  }
  
  
  func content(size: CGSize) -> some View {
    ZStack {
      card.backgroundColor
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
          cardStore.selectedElement = nil
        }
      ForEach(card.elements, id: \.id) { element in
        CardElementView(element: element, selected: cardStore.selectedElement?.id == element.id)
          .contextMenu {
            Button {
              card.remove(element)
            } label: {
              Label("Delete", systemImage: "trash")
            }
          }
          .resizableView(transform: bindingTransform(for: element),
                         viewScale: calculateScale(size))
          .frame(width: element.transform.size.width,
                 height: element.transform.size.height)
          .onTapGesture {
            cardStore.selectedElement = element
          }
      }
    }
  }
  
  var body: some View {
    RenderableView(card: $card) {
      GeometryReader { geometry in
        content(size: geometry.size)
          .frame(
            width: calculateSize(geometry.size).width ,
            height: calculateSize(geometry.size).height)
          .clipped()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        
          .onDrop(of: [.image], delegate: CardDrop(card: $card))
          .onDisappear {
            card.save()
          }
          .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
              card.save()
            }
          }
      }
    }
    .sheet(item: $currentModal) { item in
      switch item {
      case .stickerPicker:
        StickerPicker(card: $card)
      case .photoPicker:
        PhotoPicker(card: $card)
      case .pencilPicker:
        PencilPicker(pencilImage: $pencilImage)
          .onDisappear {
            if let image = pencilImage {
              card.addElement(uiImage: image)
              pencilImage = nil
            }
          }
      case .framePicker:
        FramePicker(card: $card)
          .environmentObject(cardStore)
      case .textPicker:
        TextPicker(textElement: $textElement)
          .environmentObject(cardStore)
          .onDisappear {
            if !textElement.text.isEmpty {
              card.addElement(textElement)
            }
            textElement = TextElement()
          }
      case .shareSheet:
        if let shareImage = card.shareImage {
          ShareSheetView(
            activityItems: [shareImage],
            applicationActivities: nil)
            .onDisappear {
              card.shareImage = nil
            }
        }
      }
    }
    .modifier(CardToolbarsVM(currentModal: $currentModal))
  }
}

struct CardDetailView_Previews: PreviewProvider {
  struct CardDetailPreview: View {
    @State private var card = initialCards[0]
    var body: some View {
      CardDetailView(card: $card)
        .environmentObject(CardStore(card: card))
    }
  }
  
  static var previews: some View {
    CardDetailPreview()
  }
}
