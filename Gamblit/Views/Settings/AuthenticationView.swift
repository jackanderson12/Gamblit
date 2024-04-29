//
//  AuthenticationView.swift
//  Gamblit
//
//  Created by Jack Anderson on 12/11/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import CryptoKit

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("GAMBLIT")
                .font(.system(size: 70))
                .font(.largeTitle).bold()
                .foregroundStyle(Color.orange)
                .padding(.top, 135)
                .padding(.horizontal)
            Spacer()
            Button {
                Task {
                    do {
                        try await viewModel.signInAnonymous()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Continue Without Account")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(6)
            }
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInApple()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            })
            .frame(height: 55)
            
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(content: {
            Image("SignIn")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .padding(.trailing, 80)
        })
    }
}

#Preview {
    AuthenticationView()
}
