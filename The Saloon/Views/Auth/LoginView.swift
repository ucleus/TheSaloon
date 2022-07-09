//
//  LoginView.swift
//  The Saloon
//
//  Created by SEAN BLAKE on 7/9/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Email:", text: $email)
            SecureField("Password:", text: $password)
            
            CustomButton(buttonTitle: "Log In", buttonAction: login)
        }
        .padding()
    }
    
    // MARK: - Login function...
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            // check for an error message...
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Successfully logged in")
            }
        }
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
