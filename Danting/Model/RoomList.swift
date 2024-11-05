//
//  RoomUser.swift
//  Danting
//
//  Created by DonghyeonKim on 11/5/24.
//

import UIKit

struct RoomList: Codable {
    let room_id: Int
    let title: String
    let subTitle: String
    let maxParticipants: Int
    let maleParticipants: Int
    let femaleParticipants: Int
    let ready: Bool
}
