//

import SwiftUI

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.addLines([
      CGPoint(x: rect.width * 0.13, y: rect.height * 0.2),
      CGPoint(x: rect.width * 0.87, y: rect.height * 0.47),
      CGPoint(x: rect.width * 0.4, y: rect.height * 0.93)
    ])
    path.closeSubpath()
    return path
  }
}
