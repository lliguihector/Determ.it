//
//  SceneDelegate.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 8/28/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // Define this property to switch between real and mock API managers
       let useMockAPIManager = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        
        // Initialize the window
              window = UIWindow(windowScene:  windowScene )
              
        
        
        //Choose the APIManager based on the flag
        let apiManager: APIManagerProtocol = useMockAPIManager ? MockAPIManager() : APIManager.shared
        
        let loginViewModel = LoginViewModel(apiManager: apiManager)
        
        // Initialize the LoginViewController with the view model
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController,
                  let loginViewController = navigationController.topViewController as? LogInVC {
                   loginViewController.viewModel = loginViewModel
                   window?.rootViewController = navigationController
               }
        
        window?.makeKeyAndVisible()
        
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

