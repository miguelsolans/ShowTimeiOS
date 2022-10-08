//
//  MenuItems.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import Foundation
import UIKit

struct MenuItem {
    let option : String
    let id : String
    let viewController : BaseViewController
}

struct MenuItems {
    let items: [MenuItem]
}
