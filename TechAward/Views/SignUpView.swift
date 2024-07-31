//
//  SignUpView.swift
//  TechAward
//
//  Created by justCod1ng on 27/07/24.
//

import SwiftUI
import Observation

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var user: UserData
    @State private var usingEmail = true
    @State var birthday: Date = .now
    @State var gender: Applicant.Gender = .male
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("What is your role?", selection: $user.role) {
                        Label("Applicant", systemImage: "person")
                            .tag(UserData.Role.applicant)
                        Label("Company", systemImage: "building")
                            .tag(UserData.Role.company)
                    }
                }
                Section {
                    HStack {
                        TextField(text: $user.username) {
                            Text(usingEmail ? "Enter your email" : "Enter your phone number")
                        }
                        Button { usingEmail.toggle() } label: {
                            Image(systemName: usingEmail ? "phone" : "envelope")
                        }
                    }
                    TextField("Create a password", text: $user.password)
                    TextField("Confirm your password", text: $user.confirmPassword)
                }
                switch user.role {
                case .applicant:
                    Section("Applicant Details"){
                        TextField("First Name", text: $user.applicant.firstName)
                        TextField("Middle Name", text: $user.applicant.middleName)
                        TextField("Last Name", text: $user.applicant.lastName)
                        DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                        Picker("Gender", selection: $user.applicant.gender) {
                            Text("Male")
                                .tag(Applicant.Gender.male)
                            Text("Female")
                                .tag(Applicant.Gender.female)
                        }
                            
                    }
                case .company:
                    Section("Company Details"){
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
}

#Preview {
    SignUpView(user: UserData())
}
