//
//  WelcomeView.swift
//  TechAward
//
//  Created by justCod1ng on 27/07/24.
//

import SwiftUI
import Observation

struct WelcomeView: View {
    @State private var isLoggingIn = false
    @State private var isSigningUp = false
    
    var body: some View {
        VStack {
            NavigationStack {
                Spacer()
                HStack(spacing: 100) {
                    Button {
                        isLoggingIn = true
                    } label: {
                        Text("Log In")
                    }
                    
                    Button {
                        isSigningUp = true
                    } label: {
                        Text("Sign Up")
                    }
                }
                .navigationTitle("Welcome!")
                .sheet(isPresented: $isLoggingIn) {
                    LogInView()
                }
                .sheet(isPresented: $isSigningUp) {
                    SignUpView()
                }
            }
        }
    }
}



#Preview {
    WelcomeView()
}
