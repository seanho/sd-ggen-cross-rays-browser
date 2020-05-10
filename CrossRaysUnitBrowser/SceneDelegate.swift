import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        UITableView.appearance().separatorColor = .clear

        let series = ModelGraph().build()
        let contentView = AllSeriesView(allSeries: series)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            window.overrideUserInterfaceStyle = .dark
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
