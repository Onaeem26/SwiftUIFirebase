//
//  MainView.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/26/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MainView: View {
    var db = Firestore.firestore()
    @ObservedObject var persistenceObserver: PersistenceObservation
    @State var showHomeScreen = true
    var body: some View {
        
        if persistenceObserver.uid == nil {
            ContentView()
        }else {
            ContentView()
                .fullScreenCover(isPresented: $showHomeScreen, content: {
                        HomeView(user: $persistenceObserver.user)
                  })
        }
    }
}

