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
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var confirmPassword: String = ""
    @FocusState var nameIsFocused: Bool
    
    @State var showHomeView: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                // Title
                Text("Register an Account")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(Color("ThemeSecondary"))
                    .padding(.horizontal, 20)
                
                // MARK: - TextFields
                customTextField(placeholderText: "Email", bindingProperty: email, icon: "envelope")
                    .keyboardType(.emailAddress)
                    .focused($nameIsFocused)
                    
                    
                
                // MARK: - SecureFields
                CustomSecureField(placeholder: "Password", bindingProperty: password, icon: "key.viewfinder")
                
                CustomSecureField(placeholder: "Confirm Password", bindingProperty: confirmPassword, icon: "key.viewfinder")
                
                
                // MARK: - Registration Button
                CustomButton(buttonTitle: "Register", buttonAction: {
                    registerAccount()
                    nameIsFocused = email.isEmpty
                })
                    .padding(.horizontal, 10)
                    .onAppear {
                        Auth.auth().addStateDidChangeListener { auth, user in
                            if user != nil {
                                showHomeView.toggle()
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color("ThemePrimary"))
                
            }
        }
        .padding(.horizontal, 25)
        .fullScreenCover(isPresented: $showHomeView) {
            HomeView()
        }
    }
    
    // MARK: - Custom TextField
    struct customTextField: View {
        @State var placeholderText: String = ""
        @State var bindingProperty: String
        @State var icon: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color("ThemeSecondary"))
                    .font(.headline)
                ZStack(alignment: .leading) {
                    if placeholderText.isEmpty {
                        Text("Email").bold()
                            .foregroundColor(Color("ThemeSecondary"))
                    }
                    TextField("", text: $bindingProperty)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(Color("ThemeSecondary"))
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ThemeSecondary"), lineWidth: 2))
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Custom SecureField
    struct CustomSecureField: View {
        @State var placeholder: String
        @State var bindingProperty: String
        @State var icon: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                        .foregroundColor(Color("ThemeSecondary"))
                        .font(.headline)
                SecureField(placeholder, text: $bindingProperty)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(Color("ThemeSecondary"))
                    .padding(.horizontal)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("ThemeSecondary"), lineWidth: 2))
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Register Account func
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
