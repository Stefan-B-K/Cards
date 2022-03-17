
import SwiftUI


let initialCards: [Card] = [
  Card(backgroundColor: .green, elements: initialElements),
  Card(backgroundColor: .orange),
  Card(backgroundColor: .red),
  Card(backgroundColor: .purple),
  Card(backgroundColor: .indigo)
]

let initialElements: [CardElement] = [
  ImageElement(
    transform: Transform(
      size: CGSize(width: 310, height: 225),
      rotation: .init(degrees: 10),
      offset: CGSize(width: 5, height: -245)),
    image: Image("hedgehog1")),
  ImageElement(
    transform: Transform(
      size: CGSize(width: 330, height: 238),
      rotation: .init(degrees: -25),
      offset: CGSize(width: 5, height: 200)),
    image: Image("hedgehog2")),
  ImageElement(
    transform: Transform(),
      image: Image("hedgehog3")),
  TextElement(
    transform: Transform(
      size: Settings.defaultElementSize * 1.2,
      rotation: .zero,
      offset: CGSize(width: -35, height: -125)),
    text: "Hedgehogs!!!",
    textColor: .blue)
]

func printFontFamilies() {                                        // CardStore.init(defaultData:)
    print(UIFont.familyNames)
}

let fontFamilies = ["Academy Engraved LET", "Al Nile", "American Typewriter", "Apple Color Emoji", "Apple SD Gothic Neo", "Apple Symbols", "Arial", "Arial Hebrew", "Arial Rounded MT Bold", "Avenir", "Avenir Next", "Avenir Next Condensed", "Baskerville", "Bodoni 72", "Bodoni 72 Oldstyle", "Bodoni 72 Smallcaps", "Bodoni Ornaments", "Bradley Hand", "Chalkboard SE", "Chalkduster", "Charter", "Cochin", "Copperplate", "Courier New", "Damascus", "Devanagari Sangam MN", "Didot", "DIN Alternate", "DIN Condensed", "Euphemia UCAS", "Farah", "Futura", "Galvji", "Geeza Pro", "Georgia", "Gill Sans", "Grantha Sangam MN", "Helvetica", "Helvetica Neue", "Hiragino Maru Gothic ProN", "Hiragino Mincho ProN", "Hiragino Sans", "Hoefler Text", "Kailasa", "Kefa", "Khmer Sangam MN", "Kohinoor Bangla", "Kohinoor Devanagari", "Kohinoor Gujarati", "Kohinoor Telugu", "Lao Sangam MN", "Malayalam Sangam MN", "Marker Felt", "Menlo", "Mishafi", "Mukta Mahee", "Myanmar Sangam MN", "Noteworthy", "Noto Nastaliq Urdu", "Noto Sans Kannada", "Noto Sans Myanmar", "Noto Sans Oriya", "Optima", "Palatino", "Papyrus", "Party LET", "PingFang HK", "PingFang SC", "PingFang TC", "Rockwell", "Savoye LET", "Sinhala Sangam MN", "Snell Roundhand", "Symbol", "System Font", "Tamil Sangam MN", "Thonburi", "Times New Roman", "Trebuchet MS", "Verdana", "Zapf Dingbats", "Zapfino"]

func printFontsInFamily(index: Int) {
    print(UIFont.fontNames(forFamilyName: fontFamilies[index]))
}
