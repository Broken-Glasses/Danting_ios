//
//  UserInfo.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct UserInfo {
    let member_id: String
    let student_no: String
    let gender: String
    let major: String
    
    init(member_id: String, student_no: String, gender: String, major: String) {
        self.member_id = member_id
        self.student_no = student_no
        self.gender = gender
        self.major = major
    }
}
