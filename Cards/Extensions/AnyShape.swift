//

import SwiftUI

struct AnyShape: Shape {
  private let _path: (CGRect) -> Path
  
  init<SomeShape: Shape>(_ shape: SomeShape) {
    _path = shape.path(in:)  // { rect in shape.path(in: rect) }
  }
  
  func path(in rect: CGRect) -> Path {
   _path(rect)
  }
}


extension Shape {
  func asAnyShape() -> AnyShape {
    .init(self)
  }
}


extension AnyShape: Equatable {
  static func == (lhs: AnyShape, rhs: AnyShape) -> Bool {
    let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
    let  lhsPath = lhs.path(in: rect)
    let rhsPath = rhs.path(in: rect)
    return lhsPath == rhsPath
  }
  
  
}
