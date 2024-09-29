//
//  SceneDelegate.swift
//  TicTacToe
//
//  Created by Lion on 29.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = ViewController()
        controller.view.backgroundColor = .systemRed
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

