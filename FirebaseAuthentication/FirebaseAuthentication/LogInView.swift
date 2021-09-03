//
//  LogInView.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/24/21.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var showHomeScreen: Bool = false
    
    @State var user = User()
    var db = Firestore.firestore()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Log In")
                .font(.title)
                .padding(.bottom, 44)
            TextField("Username or Email", text: $username)
                .padding(.horizontal, 32)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                .padding(.horizontal, 32)
                .padding(.top, 2)
                .foregroundColor(.gray)
            
            SecureField("Password", text: $password)
                .padding(.horizontal, 32)
                .padding(.top, 16)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
                .padding(.horizontal, 32)
                .padding(.top, 2)
                .foregroundColor(.gray)
            
            Button(action: {
                self.handleLogInTapped()
            }) {
                Capsule()
                    .frame(maxWidth: .infinity,maxHeight: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Text("Log In")
                            .foregroundColor(.white)
                            .font(.title)
                    )
                    .padding()
                    .padding(.top, 32)
                    .foregroundColor((username.isEmpty || password.isEmpty) ? .gray : .black)
                    
            }.disabled((username.isEmpty || password.isEmpty))
            Spacer()
        }.padding()
        .fullScreenCover(isPresented: $showHomeScreen, content: {
                HomeView(user: self.$user)
          })
    }
    
    func handleLogInTapped() {
        Auth.auth().signIn(withEmail: self.username, password: self.password) { authResult, error in
            if error == nil {
                print("Log In Successful",authResult)
                print("Welcome, \(Auth.auth().currentUser?.uid ?? "")")
                
                fetchDocuments(id: authResult?.user.uid ?? "")
            }
        
        }
    }
    
    func fetchDocuments(id: String) {
        db.collection("Users").whereField("id", isEqualTo: id)
          .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
                    let docs = document.data()
                    self.user = User(id: docs["id"] as? String, fullName: docs["fullName"] as? String, email: docs["email"] as? String)
                }
                
                self.showHomeScreen = true
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
