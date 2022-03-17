//

import SwiftUI

struct CardsListView: View {
  @EnvironmentObject var cardStore: CardStore
  
  func columns(size: CGSize) -> [GridItem] {
    [GridItem(.adaptive(minimum: Settings.thumbnailSize(size: size).width))]
  }
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(showsIndicators: false) {
        VStack {
          LazyVGrid(columns: columns(size: geometry.size), spacing: 30) {
            ForEach(cardStore.cards) { card in
              CardThumbnailView(card: card, size: geometry.size)
                .onTapGesture {
                  withAnimation {
                    cardStore.showAllCards = false
                  }
                  cardStore.selectedCard = card
                }
                .contextMenu {
                  Button {
                    cardStore.remove(card)
                  } label: {
                    Label("Delete", systemImage: "trash")
                  }
                }
            }
          }
        }
      }
    }
  }
}

struct CardThumbnailView: View {
  let card: Card
  var size: CGSize = .zero
  
  var body: some View {
    Group {
      if let image = UIImage.load(uuidString: card.id.uuidString) {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        card.backgroundColor
      }
    }
      .cornerRadius(10)
      .frame(width: Settings.thumbnailSize(size: size).width,
             height: Settings.thumbnailSize(size: size).height)
      .shadow(color: Color("shadow-color"), radius: 3, x: 0.0, y: 0.0)
  }
}

struct CardsListView_Previews: PreviewProvider {
  static var previews: some View {
    CardsListView()
      .environmentObject(CardStore(defaultData: true))
  }
}
