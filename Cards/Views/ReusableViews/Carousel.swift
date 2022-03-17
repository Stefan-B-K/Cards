
import SwiftUI

struct Carousel: View {
  @EnvironmentObject var store: CardStore

  var body: some View {
    GeometryReader { proxy in
      TabView {
        ForEach((0..<store.cards.count), id: \.self) { index in
          cardView(store.cards[index])
            .frame(
              width: calculateSize(proxy.size).width,
              height: calculateSize(proxy.size).height)
            .cornerRadius(15)
            .shadow(
              color: Color(white: 0.5, opacity: 0.7),
              radius: 5)
            .onTapGesture {
              store.selectedCard = store.cards[index]
              withAnimation {
                store.showAllCards = false
              }
            }
            .offset(y: -proxy.size.height * 0.05)
        }
      }
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      .tabViewStyle(PageTabViewStyle())
    }
  }

  func cardView(_ card: Card) -> some View {
    Group {
      if let image = loadCardImage(card) {
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        card.backgroundColor
      }
    }
  }

  func loadCardImage(_ card: Card) -> Image? {
    if let uiImage = UIImage.load(uuidString: card.id.uuidString) {
      return Image(uiImage: uiImage)
    }
    return nil
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
    return newSize * 0.7
  }
}

struct Carousel_Previews: PreviewProvider {
  static var previews: some View {
    Carousel()
      .environmentObject(CardStore(defaultData: true))
  }
}
