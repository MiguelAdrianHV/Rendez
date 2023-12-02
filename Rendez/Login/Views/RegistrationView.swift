//
//  RegistrationView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/28/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            // image
            Image("rendezlogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .padding(.vertical, 32)
            
            // form fields
            VStack(spacing: 24) {
                inputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                inputView(text: $fullName,
                          title: "Full Name",
                          placeholder: "Enter your full name")
                
                inputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    inputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your Password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // button
            
            Button(action: {
                Task {
                    try await viewModel.createUser(
                        withEmail: email,
                        password: password,
                        fullName: fullName)
                }
            }, label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
                )
                .background(Color(.systemOrange))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
            
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                HStack {
                    Text("Already have an account")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
            })
        }
    }
}

// MARK: - AuthenticationFormProtocol
extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    RegistrationView()
}
