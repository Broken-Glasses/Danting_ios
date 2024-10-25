//
//  Room.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit

struct Room {
    let title: String
    let subTitle: String
    var participants: [User]
    // 남성 참여자와 여성 참여자 구분하기
    let maxParticipants: Int
    
//    init(title: String, subTitle: String, maxParticipants: Int, creator: User) {
//        self.title = title
//        self.subTitle = subTitle
//        self.maxParticipants = maxParticipants
//        self.status = "unready"
//        
//        self.participants = Array(repeating: nil, count: maxParticipants)
//        self.participants[0] = creator // 방을 만든 유저가 처음 들어가야 함
//    }
    
    init(title: String, subTitle: String, participants: [User], maxParticipants: Int) {
        self.title = title
        self.subTitle = subTitle
        self.participants = participants
        self.maxParticipants = maxParticipants
    }
    
    
}
