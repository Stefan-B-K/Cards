//

import SwiftUI

struct StickerPicker: View {
  @State private var stickerPathNames: [String] = []
  @Binding var card: Card
  @Environment(\.presentationMode) var presentationMode
  
  let gridColumns = [
    GridItem(.adaptive(minimum: 120), spacing: 10)
  ]
  
  
  func loadStickers() -> [String] {
    var themes: [URL] = []
    var stickerNames: [String] = []
    
    if let resourcePath = Bundle.main.resourcePath,
       let enumerator = FileManager.default.enumerator(
        at: URL(fileURLWithPath: resourcePath + "/Stickers"),
        includingPropertiesForKeys: nil,
        options: [
          .skipsSubdirectoryDescendants,
          .skipsHiddenFiles
        ]) {
      for case let url as URL in enumerator
      where url.hasDirectoryPath {
        themes.append(url)
      }
    }
    for theme in themes {
      if let files = try? FileManager.default.contentsOfDirectory(atPath: theme.path) {
        for file in files {
          stickerNames.append(theme.path + "/" + file)
        }
      }
    }
    return stickerNames
  }
  
  func uiImage(from path: String) -> UIImage {
    print("loading:", path)
    return UIImage(named: path) ?? UIImage(named: "error-image") ?? UIImage()
  }
  
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridColumns) {
        ForEach(stickerPathNames, id: \.self) { stickerPathName in
          Image(uiImage: uiImage(from: stickerPathName))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture {
              let stickerImage = uiImage(from: stickerPathName)
              card.addElement(uiImage: stickerImage)
              presentationMode.wrappedValue.dismiss()
            }
        }
      }
    }
    .onAppear {
      stickerPathNames = loadStickers()
    }
  }
}

struct StickerPicker_Previews: PreviewProvider {
  static var previews: some View {
    StickerPicker(card: .constant(Card()))
    StickerPicker(card: .constant(Card()))
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
