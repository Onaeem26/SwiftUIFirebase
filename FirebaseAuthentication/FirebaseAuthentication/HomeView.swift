//
//  HomeView.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/25/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct HomeView: View {
    @Binding var user: User
        
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EntityViewModel()
    @State var text: String = ""
    
    @StateObject var entitiesViewModel = EntitiesViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add any text here", text: $text)
                    Button(action: {
                        handleAddButton()
                    }, label: {
                        Text("Add")
                    })
                }.padding()
                
                List(entitiesViewModel.entities) { entity in
                    Text(entity.text)
                }.padding()
                
                Spacer()
                
                
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        print(user)
                        print("Signed out")
                        self.presentationMode.wrappedValue.dismiss()
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                }, label: {
                    Text("Sign Out")
                })
            }.navigationTitle("Welcome, \(self.user.fullName ?? "")")
        
        }.onChange(of: self.user, perform: { value in
            guard let uid = value.id else { return }
            self.entitiesViewModel.fetchData(id: uid)
            
        })
        .onAppear(perform: {
            guard let uid = user.id else { return }
            self.entitiesViewModel.fetchData(id: uid)
        })
    }
    
    func handleAddButton() {
        viewModel.entity.authorID = Auth.auth().currentUser?.uid ?? ""
        viewModel.entity.text = self.text
        self.viewModel.save()
        
        self.text = ""
        
    }
}

