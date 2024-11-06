//
//  SceneDelegate.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // SplashViewController를 먼저 표시
        let splashVC = SplashViewController()
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    
        
        let logInVC = LoginViewController()
        let logInNav = UINavigationController(rootViewController: logInVC)
        let roomListVC = UINavigationController(rootViewController: RoomListViewController())

        logInNav.navigationBar.isHidden = false
        logInNav.navigationBar.setBackgroundImage(UIImage(), for: .default) // 배경 이미지 제거
        logInNav.navigationBar.shadowImage = UIImage() // 그림자 제거
        logInVC.setupNavigationBar()
        // 2초 후에 user_id 확인하여 애니메이션과 함께 화면 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
            let nextViewController: UIViewController
            
            if UserDefaults.standard.value(forKey: userIdKey) is Int {
                // user_id가 있는 경우 RoomListController로 이동
                nextViewController = roomListVC
            } else {
                // user_id가 없는 경우 LogInController로 이동
                nextViewController = logInNav
            }
            
            // 애니메이션 적용하여 화면 전환
            UIView.transition(with: self.window!,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                self.window?.rootViewController = nextViewController
            }, completion: nil)
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

