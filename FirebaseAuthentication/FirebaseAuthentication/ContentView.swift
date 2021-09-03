//
//  ContentView.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var presentLogInView: Bool = false
    @State private var presentSignUpView: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    Image("firebase")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Text("Firebase Authentication")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        
                    Spacer()
                    Button(action: {
                        print("Lets take you to log in screen")
                        self.presentLogInView = true
                    }, label: {
                        NavigationLink(
                            destination: LogInView(),
                            isActive: $presentLogInView,
                            label: {
                                Capsule()
                                    .frame(maxWidth: .infinity,maxHeight: 80, alignment: .center)
                                    .overlay(
                                        Text("Log In")
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                    .padding()
                            })
                    })
                    
                    Button(action: {
                        print("lets take you to sign up screen")
                        self.presentSignUpView = true
                    }, label: {
                        NavigationLink(
                            destination: RegisterView(),
                            isActive: $presentSignUpView,
                            label: {
                                Capsule()
                                    .frame(maxWidth: .infinity,maxHeight: 80, alignment: .center)
                                    .foregroundColor(.orange)
                                    .overlay(
                                        Text("Sign Up")
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                    .padding()
                                    .padding(.top, -4)
                            })
             
                    })
                    
                    Spacer()
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
