//
//  SceneDelegate.swift
//  NGSwiftUILargeTitlesNavigationControllerExample
//
//  Created by Noah Gilmore on 6/14/20.
//  Copyright © 2020 Noah Gilmore. All rights reserved.
//

import UIKit
import SwiftUI

struct SmallTitlesView: View {
    var body: some View {
        Text("This has a small title")
            .navigationBarTitle("Small", displayMode: .inline)
    }
}   

final class FirstViewController: UIViewController {
    var callback: () -> Void = { }

    init() {
        super.init(nibName: nil, bundle: nil)

        self.title = "Large title"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        let button = UIButton()
        button.setTitle("Push", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)

        self.view.backgroundColor = .white

        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        self.view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        self.view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc private func didTap() {
        self.callback()
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let first = FirstViewController()
            let navController = UINavigationController(rootViewController: first)
            window.rootViewController = navController
            first.callback = {
                let controller = UIHostingController(rootView: SmallTitlesView())

                // Comment in these next two lines to fix the issue
//                controller.navigationItem.largeTitleDisplayMode = .never
//                controller.navigationItem.title = "Small"
                navController.pushViewController(controller, animated: true)
            }
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

