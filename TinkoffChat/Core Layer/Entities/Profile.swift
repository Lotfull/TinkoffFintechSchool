//
//  Profile.swift
//  TinkoffChat
//
//  Created by Kam Lotfull on 20.10.17.
//  Copyright © 2017 Kam Lotfull. All rights reserved.
//

import UIKit

struct Profile {
    let name: String?
    let info: String?
    let image: UIImage?
    
    static func generate() -> Profile {
        return Profile(name: "Без имени", info: "Без инфо", image: nil)
    }
    
    func copyWithChanged(name: String? = nil, info: String? = nil, image: UIImage? = nil) -> Profile {
        return Profile(name: name ?? self.name, info: info ?? self.info, image: image ?? self.image)
    }
}

extension Profile: Equatable {
    static func ==(l: Profile, r: Profile) -> Bool {
        return l.name == r.name && l.info == r.info && l.image == r.image
    }
}
