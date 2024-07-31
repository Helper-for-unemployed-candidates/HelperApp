//
//  LogInView.swift
//  TechAward
//
//  Created by justCod1ng on 27/07/24.
//

import SwiftUI

struct LogInView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var user: LogInData
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Username") {
                    TextField("Enter your username", text: $user.username)
                }
                Section("Password") {
                    TextField("Enter your password", text: $user.password)
                }
            }
            .navigationTitle("Log In")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Log In") {
                        Task {
                            await logIn()
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func logIn() async {
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode")
            return
        }
        let url = URL(string: "https://34.27.153.209:8100/api/v1/u/auth/sign-up")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            print(data)
            print(response)
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    LogInView(user: LogInData())
}
