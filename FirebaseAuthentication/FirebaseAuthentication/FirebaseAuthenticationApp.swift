//
//  FirebaseAuthenticationApp.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/24/21.
//

import SwiftUI
import Firebase

@main
struct FirebaseAuthenticationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var persistenceObserver = PersistenceObservation()
    var body: some Scene {
        WindowGroup {
            MainView(persistenceObserver: persistenceObserver)
        }
    }
    

}
