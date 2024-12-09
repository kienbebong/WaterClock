import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        _ = SessionManager.shared
        if UserDefaults.standard.bool(forKey: "isUserSignedIn") != true {
            UserDefaults.standard.set(false, forKey: "isUserSignedIn")
        }
        
        let selectedLanguage = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "vi"
        Bundle.setLanguage(selectedLanguage)

    
        guard let windowsence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowsence)
        
        let vc = HomeViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        window.rootViewController = TabBarViewController()
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

