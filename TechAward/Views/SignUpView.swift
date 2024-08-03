//
//  SignUpView.swift
//  TechAward
//
//  Created by justCod1ng on 27/07/24.
//

import SwiftUI
import Observation

import Foundation

struct SignUpData: Codable {
    var role: String = "APPLICANT"
    var username: String = ""
    var newPassword: String = ""
    var confirmPassword: String = ""
    var applicant: Applicant = Applicant()
    var company: Company = Company()
}

struct Applicant: Codable {
    var firstName: String = ""
    var middleName: String = ""
    var lastName: String = ""
    var birthDate: String = ""
    var gender: String = ""
}

struct Company: Codable {
    var companyName: String = ""
    var companySphereId: String = ""
    var aboutCompany: String = ""
    var companyLicense: String = ""
    var officialWebsite: String = ""
}

enum Role: String, Codable {
    case applicant = "APPLICANT"
    case company = "COMPANY"
}

enum Gender: String, Codable {
    case male = "MALE"
    case female = "FEMALE"
}

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var user = SignUpData()
    @State private var usingEmail = true
    @State private var birthday: Date = .now
    @State private var gender: Gender = .male
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("What is your role?", selection: $user.role) {
                        Text("Applicant")
                            .tag(Role.applicant.rawValue)
                        Text("Company")
                            .tag(Role.company.rawValue)
                    }
                }
                Section {
                    HStack {
                        TextField(usingEmail ? "Enter your email" : "Enter your phone number", text: $user.username)
                            
                        Button { usingEmail.toggle() } label: {
                            Image(systemName: usingEmail ? "phone" : "envelope")
                        }
                    }
                    SecureField("Create a password", text: $user.newPassword)
                    SecureField("Confirm your password", text: $user.confirmPassword)
                }
                if user.role == Role.applicant.rawValue {
                    Section("Applicant Details") {
                        TextField("First Name", text: $user.applicant.firstName)
                        TextField("Middle Name", text: $user.applicant.middleName)
                        TextField("Last Name", text: $user.applicant.lastName)
                        DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        Picker("Gender", selection: $user.applicant.gender) {
                            Text("Male").tag(Gender.male.rawValue)
                            Text("Female").tag(Gender.female.rawValue)
                        }
                    }
                } else {
                    Section("Company Details") {
                        TextField("Company Name", text: $user.company.companyName)
                        TextField("Company License", text: $user.company.companyLicense)
                        TextField("Official Website", text: $user.company.officialWebsite)
                        TextField("About Company", text: $user.company.aboutCompany, axis: .vertical)
                            .lineLimit(2...3)
                    }
                }
            }
            .navigationTitle("Sign Up")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sign Up") {
                        Task {
                            await signUp()
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
    
    func signUp() async {
        // Convert date and gender before encoding
        user.applicant.birthDate = ISO8601DateFormatter().string(from: birthday)
        user.applicant.gender = gender.rawValue
        
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://104.197.130.41:8100/api/v1/u/auth/sign-up")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status: \(httpResponse.statusCode)")
            }
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SignUpView()
}
