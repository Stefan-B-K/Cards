//

import SwiftUI
import PencilKit

struct PencilPicker: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var canvas = PKCanvasView()
  @Binding var pencilImage: UIImage?

  
  var body: some View {
    
      ZStack {
        VStack {
          PencilViewRepresentable(canvas: $canvas)
          Spacer()
        }
        VStack {
          HStack {
            Button {
              presentationMode.wrappedValue.dismiss()
            } label: {
              Image(systemName: "x.circle.fill")
                .font(.headline)
                .padding()
            }
            .foregroundColor(.red)
            
            Button {
              if !canvas.drawing.strokes.isEmpty {
                pencilImage = canvas.drawing.image(from: canvas.bounds, scale: 1.0)
              }
              presentationMode.wrappedValue.dismiss()
            } label: {
              Image(systemName: "checkmark.circle.fill")
                .font(.headline)
            }
            .foregroundColor(.green)
        
            Spacer()
          }
          Spacer()
        }
    }
  }
}


struct PencilViewRepresentable: UIViewRepresentable {
  @Binding var canvas: PKCanvasView
  
  func makeUIView(context: Context) -> some UIView {
    canvas.drawingPolicy = .anyInput
    canvas.tool = PKInkingTool(.pen, color: .systemIndigo, width: 10)
    return canvas
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {

  }
  
}




struct PencilView_Previews: PreviewProvider {
  static var previews: some View {
    PencilPicker(pencilImage: .constant(UIImage()))
  }
}
