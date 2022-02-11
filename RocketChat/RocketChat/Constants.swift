//
//  Constants.swift
//  RocketChat
//
//  Created by Aurelio Le Clarke on 09.02.2022.
//

    struct K {
        static let cellIdentifier = "ReusableCell"
        static let appName = "🚀RocketChat"
        static let cellNibName = "MessageCell"
        static let registerSegue = "RegisterToChat"
        static let loginSegue = "LoginToChat"
        
        struct BrandColors {
            static let purple = "BrandPurple"
            static let lightPurple = "BrandLightPurple"
            static let blue = "BrandBlue"
            static let lighBlue = "BrandLightBlue"
        }
        
        struct FStore {
            static let collectionName = "messages"
            static let senderField = "sender"
            static let bodyField = "body"
            static let dateField = "date"
        }
    }

