//
//  WelcomeView.swift
//  TechAward
//
//  Created by justCod1ng on 27/07/24.
//

import SwiftUI
import Observation

struct WelcomeView: View {
    @State private var logInData: LogInData?
    @State private var signUpData: UserData?
    var body: some View {
        VStack {
            NavigationStack {
                Spacer()
                HStack(spacing: 100) {
                    Button {
                        logInData = LogInData()
                    } label: {
                        Text("Log In")
                    }
                    
                    Button {
                        signUpData = UserData()
                    } label: {
                        Text("Sign Up")
                    }
                }
                .navigationTitle("Welcome!")
                .sheet(item: $logInData) { item in
                    LogInView(user: item)
                        .presentationDetents([.medium])
                }
                .sheet(item: $signUpData) { item in
                    SignUpView(user: item)
                }
            }
        }
    }
}



#Preview {
    WelcomeView()
}
