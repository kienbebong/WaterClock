import UIKit
import LocalAuthentication
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        _ = SessionManager.shared
        if !UserDefaults.standard.bool(forKey: "isUserSignedIn") {
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
        
        if !UserDefaults.standard.bool(forKey: "isUserSignedIn") {
            UserDefaults.standard.set(false, forKey: "isBiometricEnabled")
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        UserDefaults.standard.set(true, forKey: "isNowBiometricEnabled")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if UserDefaults.standard.bool(forKey: "isBiometricEnabled") {
            if UserDefaults.standard.bool(forKey: "isNowBiometricEnabled") {
                authenticateUser()
            }
        }
    }

    func authenticateUser() {
        let context = LAContext()
        let reason = NSLocalizedString("FaceIDReason", comment: "")
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                DispatchQueue.main.async {
                    if success {
                        print("Xác thực thành công!")
                        UserDefaults.standard.set(false, forKey: "isNowBiometricEnabled")
                        UserDefaults.standard.set(true, forKey: "isUserSignedIn")
                        self.window?.rootViewController = TabBarViewController()
                        self.window?.makeKeyAndVisible()
                    } else {
                        self.handleAuthenticationFailure()
                    }
                }
            }
        } else {
            self.handleAuthenticationFailure()
        }
    }

    func handleAuthenticationFailure() {
        var failureCount = UserDefaults.standard.integer(forKey: "biometricFailureCount")
        failureCount += 1
        UserDefaults.standard.set(failureCount, forKey: "biometricFailureCount")
        
        if failureCount >= 3 {
            signInAgain()
        }
    }

    func signInAgain() {
        guard let window = self.window else { return }
        let homeVC = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.modalPresentationStyle = .fullScreen
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
        
        DataPersistenceManager.shared.deleteAllAccounts { result in
            switch result {
            case .success():
                print("Tài khoản đã được xóa.")
            case .failure(let error):
                print("Xảy ra lỗi khi xóa tài khoản: \(error.localizedDescription)")
            }
        }
        UserDefaults.standard.set(false, forKey: "isBiometricEnabled")
        UserDefaults.standard.set(false, forKey: "isUserSignedIn")
    }


    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

