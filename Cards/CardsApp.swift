//

import SwiftUI

@main
struct CardsApp: App {
  @StateObject var cardStore = CardStore()
  
  var body: some Scene {
    WindowGroup {
      AppLoadingView()
        .environmentObject(cardStore)
    }
  }
}
