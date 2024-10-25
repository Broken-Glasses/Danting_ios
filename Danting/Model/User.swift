//
//  UserInfo.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct User {
    let id: String
    let studentID: String
    let gender: Gender
    let major: String
    var readyState: Bool
}


enum Gender: String {
    case male, female
}
