//
//  SessionManager.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 13/11/24.
//

import Foundation

class SessionManager {
    static let shared  = SessionManager()
    
    private init() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleSignInNotification(_:)), name: Notification.Name("UserDidSignIn"), object: nil)
        }

        @objc private func handleSignInNotification(_ notification: Notification) {
            if let isUserSignedIn = notification.object as? Bool, isUserSignedIn {
                UserDefaults.standard.set(true, forKey: "isUserSignedIn")
                print("User signed in, notification received in SessionManager")
            }
        }
        
        func isUserSignedIn() -> Bool {
            return UserDefaults.standard.bool(forKey: "isUserSignedIn")
        }
}
