//
//  JoinResponse.swift
//  Danting
//
//  Created by DonghyeonKim on 11/5/24.
//

struct JoinResponse: Codable {
    var userId: Int
    var studentNo: String
    var nickName: String
    var gender: String
    var major: String
    var userRooms: [RoomDetailResponse]?
    
    private enum CodingKeys: String, CodingKey {
        case userId = "users_id"
        case studentNo = "student_no"
        case nickName
        case gender
        case major
        case userRooms
    }
}
