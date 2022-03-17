//

import SwiftUI

struct CardsView: View {
  @EnvironmentObject var cardStore: CardStore
  
  var body: some View {
    VStack {
      if cardStore.showAllCards {
        ListSelectionView(selection: $cardStore.cardListState)
      }
      ZStack {
        switch cardStore.cardListState {
        case .list:
          CardsListView()
        case .carousel:
          Carousel()
        }

        VStack {
          Spacer()
          createButton
        }
        if !cardStore.showAllCards,
           let selectedCard = cardStore.selectedCard,
           let index = cardStore.index(for: selectedCard) {
          CardDetailView(card: $cardStore.cards[index])
            .transition(.move(edge: .bottom))
            .zIndex(1)

        }
      }
      .background(Color("background"))
    .edgesIgnoringSafeArea(.all)
    }
  }
  
  var createButton: some View {
      Button {
        cardStore.selectedCard = cardStore.addCard()
        withAnimation {
          cardStore.showAllCards = false
        }
      } label: {
        Label("Добави", systemImage: "plus")
          .frame(maxWidth: .infinity)
      }
      .font(.system(size: 16, weight: .bold))
      .padding([.top, .bottom], 10)
      .background(Color("barColor"))
      .accentColor(.white)
    }
  
  
  struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
      CardsView()
        .environmentObject(CardStore(defaultData: true))
    }
  }
}
