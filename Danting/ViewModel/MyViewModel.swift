//
//  MyViewModel.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit


final class MyViewModel {
    //MARK: - Model
    
    let apiService = APIService.shared
    
    var currentUser: User? = User(nickName: "김기계", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 4)
    
    lazy var testMaleUser1: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 4),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 4)
    ]
    lazy var testFemaleUser1: [User] = [
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 4),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 2)
    ]
    
    let testMaleUser2: [User] = [
        
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 5),
    ]
    let testFemaleUser2: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "female", major: "기계공학과", readyState: false, user_id: 1),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 68)
    ]
    
    let testMaleUser3: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 1),
    ]
    
    let testFemaleUser3: [User] = [
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 5)
    ]

    let testMaleUser4: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 3),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 2),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 9),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 12),
    ]
    let testFemaleUser4: [User] = [
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 8),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 10),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 11),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 14)
    ]
    
    let testMaleUser5: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 15),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 17),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 15),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 15),
    ]

    let testFemaleUser5: [User] = [
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 15),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 15),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 15),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 15)
    ]
    
    let testMaleUser6: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 15),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 14),
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 16),
        User(nickName: "Alex", student_no: "32180956", gender: "male", major: "전자전기공학과", readyState: false, user_id: 17),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 21),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 25)
    ]

    let testFemaleUser6: [User] = [
        User(nickName: "Jane", student_no: "32200956", gender: "female", major: "경영학과", readyState: false, user_id: 16),
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 21),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 25)
    ]

    
    let testMaleUser7: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 16),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 54),
    ]
    let testFemaleUser7: [User] = [
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 35),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 85)
    ]
    let testMaleUser8: [User] = [
        User(nickName: "John", student_no: "32190956", gender: "male", major: "기계공학과", readyState: false, user_id: 26),
        User(nickName: "Mike", student_no: "32220956", gender: "male", major: "기계공학과", readyState: false, user_id: 29),

    ]
    let testFemaleUser8: [User] = [
        User(nickName: "Lily", student_no: "32240956", gender: "female", major: "화학공학과", readyState: false, user_id: 90),
        User(nickName: "Emily", student_no: "32230956", gender: "female", major: "경영학과", readyState: false, user_id: 9)
    ]
    
    lazy var rooms: [Room]? = [Room(room_id: 1, title: "진짜 술고래들만 들어와라", subTitle: "이거 보여주려고 어그로 끌었다 미안하다...", maxParticipants: 6,
                                    maleParticipants: self.testMaleUser1, femaleParticipants: self.testFemaleUser1),
                             Room(room_id: 2, title: "공대 차은우입니다.", subTitle: "카리나 구합니다. 윈터도 괜찮습니다.", maxParticipants: 4,
                                  maleParticipants: self.testMaleUser2, femaleParticipants: self.testFemaleUser2),
                             Room(room_id: 3, title: "친구 만들사람~~~🤗", subTitle: "mbti 극I인 사람들 우리도 친구 만들어보자!!!", maxParticipants: 6,
                                  maleParticipants: self.testMaleUser3, femaleParticipants: self.testFemaleUser3),
                               Room(room_id: 4, title: "군 필 신 입 생", subTitle: "군필 신입생. 더 이상 무슨 말이 필요하죠?", maxParticipants: 8,
                                    maleParticipants: self.testMaleUser4, femaleParticipants: self.testFemaleUser4),
                               Room(room_id: 5, title: "여기 비쥬얼 연애대상", subTitle: "저희는 외모 안봐요. 성격 좋은 남자분들, 재밌는 남자분들 들어오세욥", maxParticipants: 8, maleParticipants: self.testMaleUser5, femaleParticipants: self.testFemaleUser5),
                               Room(room_id: 6, title: "고인물도 과팅하자", subTitle: "18-21학번까지만 받겠습니다. 고인물도 사랑을 찾고 싶어요", maxParticipants: 6, maleParticipants: self.testMaleUser6, femaleParticipants: self.testFemaleUser6),
                               Room(room_id: 7, title: "이성 친구 만들 사람은 들어와", subTitle: "남고 여고출신이라 이성 친구가 없는 사람 환영해요", maxParticipants: 4, maleParticipants: self.testMaleUser7, femaleParticipants: self.testFemaleUser7),
                               Room(room_id: 8,  title: "단국 뉴진스 만날사람", subTitle: "유유유유유유유유유~~~ 매그네~~~~릭", maxParticipants: 4, maleParticipants: self.testMaleUser8, femaleParticipants: self.testFemaleUser8)]
        
    var room: Room? {
        didSet {
            guard let room = self.room else { return }
            didFetchRoom?(room)
        }
    }
    
    var didFetchRoom: ((Room) ->(Void))?
    
    var didFetchRooms: (([Room])->(Void))?
    
    func updateCurrentUser(_ currentUser: User) {
        self.currentUser = currentUser
    }
    
    
    func createUser(nickname: String, student_no: String, major: String, gender: String, completionHandler: @escaping () -> Void) {
        apiService.createUser(nickname: nickname, student_no: student_no, major: major, gender: gender) { serverResponse in
            switch serverResponse {
            case .success(let result):
                let user_id = result.result.userId // 직접 사용
                UserDefaults.standard.setValue(user_id, forKey: userIdKey)
                UserDefaults.standard.setValue(nickname, forKey: nicknameKey)
                print(result)
                completionHandler()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


    
    
    
    
    
    
}

