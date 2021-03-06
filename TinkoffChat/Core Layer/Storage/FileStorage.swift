//
//  File.swift
//  TinkoffChat
//
//  Created by Kam Lotfull on 21.10.17.
//  Copyright © 2017 Kam Lotfull. All rights reserved.
//

import UIKit

class FileStorage {
    var objects = [Any?]()
    var newChanges = false
    
    var lastMethod: String = "Opening VC"
    var keyboardSize: CGRect? = nil
    var show: CGFloat = 1.0
    var cornerRadius: CGFloat = 0.0
    var activeTextField: UITextField?
    
    func save(_ profile: Profile) -> Bool {
        let image = profile.image //as Any?
        let name = profile.name //as Any?
        let info = profile.info// as Any?
        let objects: [Any?] = [image, name, info] as [Any?]
        let answer = NSKeyedArchiver.archiveRootObject(objects, toFile: filePath)
        print("******* \(answer) *******")
        return answer
    }
    
    func loadProfile() -> Profile? {
        if let objects = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Any?] {
            if let image = objects[0] as? UIImage?,
                let name = objects[1] as? String,
                let info = objects[2] as? String? {
                return Profile(name: name, info: info, image: image)
            }
        }
        return nil
    }
    
    // MARK: - Vars
    private var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        return (url.appendingPathComponent(FileStorage.fileName)?.path)!
    }
    private static let fileName = "profileData"
    private static let profileNameKey = "profileName"
    private static let profileInfoKey = "profileInfo"
    private static let profileImageKey = "profileImage"
}

