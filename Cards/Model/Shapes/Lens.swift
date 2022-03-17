//

import SwiftUI

struct Lens: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.midY))
    path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.midY),
                      control: CGPoint(x: rect.midX, y: rect.height * 0.1))
    path.addQuadCurve(to: CGPoint(x: 0, y: rect.midY),
                      control: CGPoint(x: rect.midX, y: rect.height * 0.7))
    path.closeSubpath()
    return path
  }
}
