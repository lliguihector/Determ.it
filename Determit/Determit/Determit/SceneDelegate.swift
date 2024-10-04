//
//  SceneDelegate.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 8/28/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // Define this property to switch between real and mock API managers
    let useMockAPIManager = true
    var window: UIWindow?
 

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        
        // Initialize the window
        window = UIWindow(windowScene: windowScene)
        
        //Choose the APIManager based on the flag
        let apiManager: APIManagerProtocol = useMockAPIManager ? MockAPIManager() : APIManager.shared
        let loginViewModel = LoginViewModel(apiManager: apiManager)
        
        let loginRootViewController = createLoginNavigationController()
        
        window?.rootViewController = loginRootViewController
        window?.makeKeyAndVisible()
        
    }
    
    
    
    func createLoginNavigationController() -> UINavigationController{
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LogInVC else{
            fatalError("Unable to instantiate Login view from storyboard")
        }
        
        return NavigationController(rootViewController: loginVC)
        
    }
    
    //Tab Bar
    func createTabbar()-> UITabBarController{
        
        let tabbar = UITabBarController() //Create the tab bar controller
        UITabBar.appearance().tintColor = .systemBlue
        tabbar.viewControllers = [createHomeNavigationController(),createEmployeeNavigationController(), createMapLocationNavigationController(),createSettingsNavigationController()] //set the array of viewcontrollers
        return tabbar
    }
    
    
   //Settings
    func createSettingsNavigationController() -> UINavigationController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")as? AccountVC else{
            fatalError("Unable to instantiate AccountVC from storyboard")

        }
        

        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 0)
        
        return NavigationController(rootViewController: settingsVC)

    }
    
    //Home
    func createHomeNavigationController() -> UINavigationController{
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        guard let homeVC = storyboard.instantiateViewController(withIdentifier: "AdminViewController")as? AdminView else{
            fatalError("Unable to instantiate LocationVC from storyboard")
        }
        

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        return NavigationController(rootViewController: homeVC)

    }
    
    //Employee
    func createEmployeeNavigationController() -> UINavigationController{
            let employeeVC = EmployeeView()
            
        employeeVC .title = "Employee"
        employeeVC .tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            
            return UINavigationController(rootViewController: employeeVC)
       
        }
    
    //Location Map
    func createMapLocationNavigationController() -> UINavigationController{
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        guard let locationVC = storyboard.instantiateViewController(withIdentifier: "LocationViewController")as? LocationVC else{
            fatalError("Unable to instantiate LocationVC from storyboard")
        }
        

        locationVC.tabBarItem = UITabBarItem(title: "Destination", image: UIImage(systemName: "location.circle.fill"), tag: 0)
        
        return NavigationController(rootViewController: locationVC)
        
        
    }
    
    //Mock Login
    private func setupRootViewController(with viewModel: LoginViewModel){
        
        // Initialize the LoginViewController with the view model
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController,
                  let loginViewController = navigationController.topViewController as? LogInVC {
                   loginViewController.viewModel = viewModel
                   window?.rootViewController = navigationController
               }
        
        
        
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

