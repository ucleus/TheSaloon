//
//  RegistrationView.swift
//  The Saloon
//
//  Created by SEAN BLAKE on 7/9/22.
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State var showHomeView: Bool = false
    
    var body: some View {
        VStack {
            Text("Register an Account")
            
            TextField("Email", text: $email)
            
            SecureField("Password", text: $password)
            
            CustomButton(buttonTitle: "Register", buttonAction: {registerAccount()})
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            showHomeView.toggle()
                        }
                    }
                }
        }
        .fullScreenCover(isPresented: $showHomeView) {
            HomeView()
        }
    }
    
    func registerAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("User sign up successfully.")
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
