//
//  SceneDelegate.swift
//  MuiscTempoWithHR
//
//  Created by Zach on 5/20/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        showStartScreen()
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

    private func showStartScreen() {
        guard let window = self.window else {
            fatalError("No window to attach our controller, should never happen")
        }
        
        let navigationController = UINavigationController()
        
        let mainView = MainViewController.instantiateViewController()
        let songURLs = getSongURLs()
        let mainPresenter = MainPresenter(view: mainView, songURLs: songURLs)
        mainView.delegate = mainPresenter
        mainView.dataSource = mainPresenter
        
        window.rootViewController = navigationController
        navigationController.pushViewController(mainView, animated: true)
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        // change the root view controller to your specific view controller
        DispatchQueue.main.async {
            window.rootViewController = vc
        }
    }
    private func getSongURLs() -> [URL] {
        var songPaths: [URL] = []
        
        // Get the URL for the app bundle
        guard let bundleURL = Bundle.main.resourceURL else {
            print("Failed to locate app bundle.")
            return []
        }
        
        // Get the URLs for all files in the app bundle
        guard let fileURLs = try? FileManager.default.contentsOfDirectory(at: bundleURL, includingPropertiesForKeys: nil) else {
            print("Failed to retrieve contents of app bundle.")
            return []
        }
        
        // Filter the file URLs to include only those with .mp3 extension
        for fileURL in fileURLs {
            if fileURL.pathExtension == "mp3" {
                songPaths.append(fileURL)
                print("SONG URL" + fileURL.absoluteString)
            }
        }
        
        return songPaths
    }
}
    

