//
//  SceneDelegate.swift
//  TextView
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        UIView.appearance().tintColor = UIColor(named: "GlobalTint")
    }
}
