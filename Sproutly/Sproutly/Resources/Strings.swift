//
//  Strings.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 11.08.2025.
//

import Foundation

struct Strings {
    struct Onboarding {
        static let getStartedTitle = String(localized: "start", defaultValue: "Start")
    }
    
    struct Journal {
        static let journalTitle = String(localized: "journal", defaultValue: "Journal")
        static let journalEntryTitle = String(localized: "journalEntries", defaultValue: "Journal Entries")
        static let journalNoEntryText = String(localized: "journalNoEntries", defaultValue: "No Entries Yet")
    }
    
    struct Profile {
        static let profileTitle = String(localized: "profile", defaultValue: "Profile")
    }
    
    struct Login {
        static let usernameText = String(localized: "username", defaultValue: "Username")
        static let passwordText = String(localized: "password", defaultValue: "Password")
        static let loginText = String(localized: "login", defaultValue: "Login")
        static let logOutText = String(localized: "logout", defaultValue: "Log Out")
    }
}
