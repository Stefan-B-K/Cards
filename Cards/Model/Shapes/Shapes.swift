//

import SwiftUI

struct Shapes: View {
  let currentShape = Cone()                                       // just for preview
  
  var body: some View {
    currentShape
      .stroke(Color.primary, style: StrokeStyle(lineWidth: 10, lineJoin: .round))
      .aspectRatio(1, contentMode: .fit)
      .background(Color.yellow)
  }

  static let shapes: [AnyShape] = [
    
    Rectangle().asAnyShape(),
    Circle().asAnyShape(),
    Ellipse().asAnyShape(),
    Triangle().asAnyShape(),
    Cone().asAnyShape(),
    Lens().asAnyShape()
    
  ]
  
}






struct ShapesPicker_Previews: PreviewProvider {
  static var previews: some View {
    Shapes()
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
