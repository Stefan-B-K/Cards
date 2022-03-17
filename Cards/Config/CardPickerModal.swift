//
//import SwiftUI

enum CardPickerModal: CaseIterable, Identifiable {
  var id: Int { hashValue }
  
  case photoPicker, framePicker, stickerPicker, textPicker, pencilPicker, shareSheet
  
  var info: (text: String, imageName: String) {
    switch self {
    case .photoPicker: return ("Photos", "photo")
    case .framePicker: return ("Frames", "square.on.circle")
    case .stickerPicker: return ("Stickers", "heart.circle")
    case .textPicker: return ("Text", "textformat")
    case .pencilPicker: return("Pencil", "scribble")
    case .shareSheet: return("Share", "square.and.arrow.up")
    }
  }
}
