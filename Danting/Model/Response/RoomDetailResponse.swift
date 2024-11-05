//
//  Room.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.

import UIKit

struct RoomDetailResponse: Codable {
    let room_id: Int
    let title: String
    let subTitle: String
    let maxParticipants: Int
    var maleParticipants: [RoomDetailUserResponse]
    var femaleParticipants: [RoomDetailUserResponse]
    var ready: Bool = false
}
