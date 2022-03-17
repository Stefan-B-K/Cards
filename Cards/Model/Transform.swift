//

import SwiftUI

struct Transform {
  var size: CGSize = CGSize(width: Settings.defaultElementSize.width,
                            height: Settings.defaultElementSize.height)
  var rotation: Angle = .zero
  var offset: CGSize = .zero
}

extension Transform: Codable {}
