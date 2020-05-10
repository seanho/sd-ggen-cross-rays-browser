import UIKit

extension UIColor {
    func lighten(by value: CGFloat = 0.3) -> UIColor {
        adjust(by: abs(value) )
    }

    func darken(by value: CGFloat = 0.1) -> UIColor {
        adjust(by: -1 * abs(value) )
    }

    func adjust(by value: CGFloat = 0.3) -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(
                red: min(r + value, 1.0),
                green: min(g + value, 1.0),
                blue: min(b + value, 1.0),
                alpha: a
            )
        } else {
            return self
        }
    }
}
