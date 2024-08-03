////
////  UserDataModel.swift
////  TechAward
////
////  Created by justCod1ng on 28/07/24.
////
//
//import Foundation
//import Observation
//
//@Observable
//class LogInData: Codable, Identifiable {
//    var username: String = ""
//    var password: String = ""
//    
//    enum CondingKeys: String, CodingKey {
//        case _username = "username"
//        case _password = "password"
//    }
//}
//
//@Observable
//class UserData: Identifiable, Codable {
//    enum Role: Codable {
//        case applicant
//        case company
//    }
//
//    var role: Role = .applicant
//    var applicant: Applicant = Applicant()
//    var company: Company = Company()
//    var username: String = ""
//    var password: String = ""
//    var confirmPassword: String = ""
//    
//    enum CodingKeys: String, CodingKey {
//        case _role = "role"
//        case _applicant = "applicant"
//        case _company = "company"
//        case _username = "username"
//        case _password = "password"
//        case _confirmPassword = "confirmPassword"
//    }
//
////    func toJSON() -> [String: Any] {
////        var data: [String: Any] = [
////            "role": role == .applicant ? "APPLICANT" : "COMPANY",
////            "username": username,
////            "password": password,
////            "confirmPassword": confirmPassword
////        ]
////
////        switch role {
////        case .applicant:
////            data["applicant"] = applicant.toDictionary()
////        case .company:
////            data["company"] = company.toDictionary()
////        }
////
////        return data
////    }
//}
//
//struct Applicant: Codable {
//    var firstName: String = ""
//    var middleName: String = ""
//    var lastName: String = ""
//    var birthDate: String = ""
//    var gender: Gender = .male
//    
//    enum Gender: Codable {
//        case male, female
//    }
//
////    func toDictionary() -> [String: Any] {
////        return [
////            "firstName": firstName,
////            "middleName": middleName,
////            "lastName": lastName,
////            "birthDate": birthDate,
////            "gender": gender == .male ? "MALE" : "FEMALE"
////        ]
////    }
//}
//
//struct Company: Codable {
//    var companyName: String = ""
//    var companySphereId: String = ""
//    var aboutCompany: String = ""
//    var companyLicense: String = ""
//    var officialWebsite: String = ""
//
////    func toDictionary() -> [String: Any] {
////        return [
////            "companyName": companyName,
////            "companySphereId": companySphereId,
////            "aboutCompany": aboutCompany,
////            "companyLicense": companyLicense,
////            "officialWebsite": officialWebsite
////        ]
////    }
//}
