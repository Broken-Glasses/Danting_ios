//
//  JoinRequest.swift
//  Danting
//
//  Created by DonghyeonKim on 11/5/24.
//

struct JoinRequest: Codable {
    var studentNo: String
    var gender: String
    var major: String
    
    private enum CodingKeys: String, CodingKey {
        case studentNo = "student_no"
        case gender
        case major
    }
}
