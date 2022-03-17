//

import SwiftUI

struct Cone: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let radius = min(rect.midX, rect.midY)
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius,
                startAngle: .degrees(180) , endAngle: .degrees(0), clockwise: true)
    path.addLine(to: CGPoint(x: rect.midX, y: 0))
    path.addLine(to: CGPoint(x: rect.midX - radius, y: rect.midY))
    path.closeSubpath()
    return path
  }
}
