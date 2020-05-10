import SwiftUI

struct SegmentedProgressView: View {
    var value: Int = 0
    var maximum: Int = 10
    var spacing: CGFloat = 4
    var color: Color = Color(UIColor.systemBlue)

    var body: some View {
        HStack(spacing: spacing) {
          ForEach(0..<maximum) { index in
            Rectangle()
                .foregroundColor(index < self.value ? self.color : Color(UIColor.systemGray2))
          }
        }
        .clipShape(Capsule())
    }
}
