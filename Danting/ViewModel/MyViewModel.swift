//
//  MyViewModel.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit


final class MyViewModel {
    //MARK: - Model
    var currentUser: User? = User(nickName: "김기계", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 4)
    
    lazy var testUser1: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 4),
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 4),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 4),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 2)
    ]

    let testUser2: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 1),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 5),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 68)
    ]

    let testUser3: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 1),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 5)
    ]

    let testUser4: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 3),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 2),
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 8),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 9),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 10),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 11),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 12),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 14)
    ]

    let testUser5: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 15),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 17),
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 15),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 15),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 15),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 15),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 15),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 15)
    ]

    let testUser6: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 15),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 14),
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 16),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 17),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 21),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 25)
    ]

    let testUser7: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 16),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 54),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 35),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 85)
    ]

    let testUser8: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 26),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 29),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 90),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 9)
    ]

    
    lazy var roomList: [Room]? = [Room(room_id: "1", title: "진짜 술고래들만 들어와라", subTitle: "이거 보여주려고 어그로 끌었다 미안하다...", participants:                          self.testUser1, maxParticipants: 6),
                             Room(room_id: "1", title: "공대 차은우입니다.", subTitle: "카리나 구합니다. 윈터도 괜찮습니다.", participants: self.testUser2, maxParticipants: 4),
                             Room(room_id: "1", title: "친구 만들사람~~~🤗", subTitle: "mbti 극I인 사람들 우리도 친구 만들어보자!!!", participants: self.testUser3, maxParticipants: 6),
                             Room(room_id: "1", title: "군 필 신 입 생", subTitle: "군필 신입생. 더 이상 무슨 말이 필요하죠?", participants: self.testUser4, maxParticipants: 8),
                             Room(room_id: "1", title: "여기 비쥬얼 연애대상", subTitle: "저희는 외모 안봐요. 성격 좋은 남자분들, 재밌는 남자분들 들어오세욥", participants: self.testUser5, maxParticipants: 8),
                             Room(room_id: "1", title: "고인물도 과팅하자", subTitle: "18-21학번까지만 받겠습니다. 고인물도 사랑을 찾고 싶어요", participants: self.testUser6, maxParticipants: 6),
                             Room(room_id: "1", title: "이성 친구 만들 사람은 들어와", subTitle: "남고 여고출신이라 이성 친구가 없는 사람 환영해요", participants: self.testUser7, maxParticipants: 4),
                             Room(room_id: "1",  title: "단국 뉴진스 만날사람", subTitle: "유유유유유유유유유~~~ 매그네~~~~릭", participants: self.testUser8, maxParticipants: 4)]
        
    var room: Room?
    
    
    func updateCurrentUser(_ currentUser: User) {
        self.currentUser = currentUser
    }
    
    
    func makeUserInfo(student_no: String, gender: String, major: String) {
       
    }
    
    
    func postUserInfo() {
        
    }
    
    
    
    
}