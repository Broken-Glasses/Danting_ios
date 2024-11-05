//
//  UserInfo.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct User: Codable {
    let student_no: String
    let nickname: String = "김단국"
    let gender: String
    let major: String
    var ready: Bool
    let user_id: Int?
}
