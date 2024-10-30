//
//  Room.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct Room: Codable {
    let room_id: String // room_id는 생성할 때, 서버에 던져주기?
    let title: String
    let subTitle: String
    var participants: [User]
    let maxParticipants: Int
    
}
