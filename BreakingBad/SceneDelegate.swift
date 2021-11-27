//
//  SceneDelegate.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import UIKit
import BreakingBadAppDomain
import BreakingBadData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()


        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .shared
        let urlSession = URLSession(configuration: configuration)
        let imageLoader = ImageCacheLoaderURLSession(
            urlSession: urlSession
        )


        let characterListVC = CharacterListViewController(
            viewModel: CharacterListViewModel(
                useCase: CharacterListUseCaseImp(
                    characterListRepository: CharacterListRepositoryImp(
                        api: CharacterListAPI(),
                        urlSession: .shared,
                        mapper: CharacterMapper()
                    )
                ),
                imageLoader: imageLoader
            )
        )

        characterListVC.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )

        let episodeListVC = UIViewController()
        episodeListVC.view.backgroundColor = .blue
        episodeListVC.tabBarItem = UITabBarItem(
            title: "Episodes",
            image: UIImage(systemName: "film"),
            selectedImage: UIImage(systemName: "film.fill")
        )

        let quoteListVC = UIViewController()
        quoteListVC.view.backgroundColor = .brown
        quoteListVC.tabBarItem = UITabBarItem(
            title: "Quotes",
            image: UIImage(systemName: "quote.bubble"),
            selectedImage: UIImage(systemName: "quote.bubble.fill")
        )

        tabBarController.viewControllers = [
            characterListVC,
            episodeListVC,
            quoteListVC
        ]
        tabBarController.selectedIndex = 0

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

