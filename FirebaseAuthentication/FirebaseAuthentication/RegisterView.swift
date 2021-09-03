//
//  RegisterScreen.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/25/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct RegisterView: View {
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showAlert: Bool = false
    @State var showHomeScreen: Bool = false
    
    var db = Firestore.firestore()
    
   
    @State var user = User()
    
    var body: some View {
        
        VStack {
            //Spacer()
            Text("Register Account")
                .font(.title)
                .padding(.bottom, 16)
                
          
            TextField("Full Name", text: $fullName)
                .padding(.horizontal, 32)
                .modifier(CustomBorder())
                
            
            TextField("Email", text: $email)
                .padding(.horizontal, 32)
                .padding(.top, 16)
                .modifier(CustomBorder())
            
            
            SecureField("Password", text: $password)
                .padding(.horizontal, 32)
                .padding(.top, 16)
                .modifier(CustomBorder())
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding(.horizontal, 32)
                .padding(.top, 16)
                .modifier(CustomBorder())
                
            Button(action: {
                self.handleRegisterTapped()
            }) {
                Capsule()
                    .frame(maxWidth: .infinity,maxHeight: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Text("Register")
                            .foregroundColor(.white)
                    )
                    .padding()
                    .padding(.top, 32)
                  
                    
            }
            
            Spacer()
            
           
        }.padding()
       
            
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Password doesn't match"), message: Text("Please rewrite your password"), dismissButton: .default(Text("Okay!")))
        }
        .fullScreenCover(isPresented: $showHomeScreen, content: {
                HomeView(user: self.$user)   // <--- here
          })  
    }
    
    func handleRegisterTapped() {
        if self.password != confirmPassword {
            print("Error - Passwords don't match")
            self.showAlert = true
            return
        }
        
        
        Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
            let id = result?.user.uid
            self.user = User(id: id, fullName: self.fullName, email: self.email)
            print("hghg",user.id)
            do {
                let _ = try db.collection("Users").addDocument(from: user)
                self.showHomeScreen = true
            }catch {
                print(error)
            }
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct CustomBorder: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
        content
            
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 1, alignment: .center)
            .padding(.horizontal, 32)
            .padding(.top, 2)
            .foregroundColor(.gray)
        }
    }
}
