//
//  AuthViewModel.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/28/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var UserSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.UserSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.UserSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.UserSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser =  try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.UserSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with errors \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        do {
            
            if let user = Auth.auth().currentUser {
                user.delete { error in
                    if let error = error {
                        print("Error deleting account: \(error.localizedDescription)")
                    } else {
                        print("Account deleted successfully!")
                    }
                }
            }
            
            try Auth.auth().signOut()
            self.UserSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with errors \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
