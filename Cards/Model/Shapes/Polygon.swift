//

import SwiftUI

struct Polygon: Shape {
  let sides: Int

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let radius = min(rect.midX, rect.midY)
    let angle = CGFloat.pi * 2 / CGFloat(sides)
    let points: [CGPoint] = (0..<sides).map { index in
      let currentAngle = angle * CGFloat(index)
      let pointX = radius * cos(currentAngle) + radius
      let pointY = radius * sin(currentAngle) + radius
      return CGPoint(x: pointX, y: pointY)
    }
    path.move(to: points[0])
    for i in 1..<points.count {
      path.addLine(to: points[i])
    }
    path.closeSubpath()
    return path
  }
}
