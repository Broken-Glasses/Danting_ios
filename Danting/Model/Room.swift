//
//  Room.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct Room: Codable {
    let room_id: Int
    let title: String
    let subTitle: String
    let maxParticipants: Int
    var maleParticipants: [User]
    var femaleParticipants: [User]
    var isReady: Bool = false
}
