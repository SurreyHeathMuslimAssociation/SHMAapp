//
//  Page.swift
//  SHMA
//
//  Created by Umar Yaqub on 28/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Page {
    
    let title: String
    let message: String
    let type: PageType
    
    init(title: String, message: String, type: PageType) {
        self.title = title
        self.message = message
        self.type = type
    }
}

enum PageType {
    case welcome
    case detail
    case payment
}
