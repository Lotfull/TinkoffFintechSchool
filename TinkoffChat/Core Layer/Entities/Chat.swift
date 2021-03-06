//
//  Chat.swift
//  TinkoffChat
//
//  Created by Kam Lotfull on 20.10.17.
//  Copyright © 2017 Kam Lotfull. All rights reserved.
//

import Foundation
import CoreData

extension Chat {
    static func findOrInsertChat(withID chatID: String, in context: NSManagedObjectContext) -> Chat {
        
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            assertionFailure("Model is not available in context!")
            fatalError()
        }
        guard let fetchRequest = Chat.fetchRequestChat(withChatID: chatID, model: model) else {
            assertionFailure("Chat.fetchRequestChat == nil")
            fatalError()
        }
        var chat: Chat?
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple chats found!")
            print("*** chat results\n", results)
            if let foundChat = results.first {
                chat = foundChat
            }
        } catch {
            print("Failed to fetch Chat: \(error)")
        }
        if chat == nil {
            print(#function, "chat == nil")
            chat = Chat.insertChat(with: chatID, in: context)
        }
        return chat!
    }
    
    static func fetchRequestChat(withChatID ID: String, model: NSManagedObjectModel) -> NSFetchRequest<Chat>? {
        let requestName = "ChatByID"
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: requestName, substitutionVariables: ["id" : ID]) as? NSFetchRequest<Chat> else {
            assert(false, "No fetch request template with name \(requestName)")
            return nil
        }
        return fetchRequest
    }
    
    static func insertChat(with ID: String, in context: NSManagedObjectContext) -> Chat? {
        if let chat = NSEntityDescription.insertNewObject(forEntityName: "Chat", into: context) as? Chat {
            chat.id = ID
            chat.isOnline = true
            let user = User.findOrInsertUser(withID: ID, in: context)
            chat.user = user
            print(#function, chat)
            print(#function, user)
            return chat
        }
        return nil
    }
    
    static func generateChatID() -> String {
        return ("Chat-\(arc4random_uniform(1000))-\(Date.timeIntervalSinceReferenceDate)".data(using: .utf8)?.base64EncodedString())!
    }
}
