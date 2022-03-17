//

import SwiftUI

struct ResizableVM: ViewModifier {
  @State private var previousOffset: CGSize = .zero
  @State private var previousRotation: Angle = .zero
  @State private var scale: CGFloat = 1.0
  @Binding  var transform: Transform
  
  let viewScale: CGFloat
  
  init(transform: Binding<Transform>, viewScale: CGFloat = 1.0) {
    _transform = transform
    self.viewScale = viewScale
  }
  
  func body(content: Content) -> some View {
    let scaleGesture = MagnificationGesture()
      .onChanged { scale in
        self.scale = scale
      }
      .onEnded { scale in
        transform.size.width *= scale
        transform.size.height *= scale                                  
        self.scale = 1.0
      }
    
    let rotateGesture = RotationGesture()
      .onChanged { rotation in
        transform.rotation += rotation - previousRotation
        previousRotation = rotation
      }
      .onEnded { _ in
        previousRotation = .zero
      }
    
    let dragGesture = DragGesture()
      .onChanged { value in
        transform.offset = previousOffset + value.translation     // custom +
      }
      .onEnded { _ in
        previousOffset = transform.offset
      }
    content
      .frame(width: transform.size.width, height: transform.size.height)
      .rotationEffect(transform.rotation)
      .scaleEffect(scale)
      .offset(transform.offset)
      .gesture(dragGesture)
      .gesture(SimultaneousGesture(rotateGesture, scaleGesture))
      .onAppear {
        previousOffset = transform.offset
      }
  }
}


extension View {
  func resizableView(transform: Binding<Transform>, viewScale: CGFloat) -> some View {
    return modifier(ResizableVM(transform: transform, viewScale: viewScale))
  }
}



struct ResizableView_Previews: PreviewProvider {
  static var previews: some View {
      RoundedRectangle(cornerRadius: 30.0)
            .foregroundColor(Color.red)
            .resizableView(transform: .constant(Transform()), viewScale: 1.0)

  }
}
