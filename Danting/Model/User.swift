//
//  UserInfo.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct User: Codable {
    let nickName: String
    let student_no: String
    let gender: String
    let major: String
    var readyState: Bool
    let user_id: String?
    
}
