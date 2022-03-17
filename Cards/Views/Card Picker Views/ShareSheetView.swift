
import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
  let activityItems: [UIImage]
  let applicationActivities: [UIActivity]?

  func makeUIViewController(context: Context) -> some UIViewController {
    UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: applicationActivities)
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
