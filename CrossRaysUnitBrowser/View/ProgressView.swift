import SwiftUI

struct ProgressView: View {
    var value: Float
    var maximum: Float = 100
    var startColor: Color = Color(UIColor.systemBlue.darken())
    var endColor: Color = Color(UIColor.systemBlue.lighten())

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemGray2))
                LinearGradient(gradient: Gradient(colors: [self.startColor, self.endColor]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .clipShape(Rectangle().offset(x: -(geometry.size.width - CGFloat(self.value / self.maximum) * geometry.size.width), y: 0))
            }
            .clipShape(Capsule())
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 60, maximum: 100)
            .frame(width: 300, height: 6)
            .environment(\.colorScheme, .dark)
    }
}
