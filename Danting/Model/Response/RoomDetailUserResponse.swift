//
//  RoomUserResponse.swift
//  Danting
//
//  Created by DonghyeonKim on 11/5/24.
//

struct RoomDetailUserResponse: Codable {
    let student_no: String
    let nickname: String
    let gender: String
    let major: String
    let user_id: Int
    let ready: Bool
}
