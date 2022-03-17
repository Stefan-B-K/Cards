//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var card: Card
  
  class PhotosCoordinator: NSObject, PHPickerViewControllerDelegate {       // NSObject ! ! ! ! ! !
    let parent: PhotoPicker
    
    init(parent: PhotoPicker) { self.parent = parent }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      let itemProviders = results.map(\.itemProvider)             // map { $0.itemProvider }
      loadAddImages(from: itemProviders, to: self.parent.$card)   // CardDrop
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
  
  func makeCoordinator() -> PhotosCoordinator {
    PhotosCoordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    configuration.selectionLimit = 0
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
  }
}



struct PhotoPicker_Preview: PreviewProvider {
  static var previews: some View {
    PhotoPicker(card: .constant(Card()))
      .background(Color.yellow)
  }
}
