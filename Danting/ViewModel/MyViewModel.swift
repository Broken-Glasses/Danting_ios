//
//  MyViewModel.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit


final class MyViewModel {
    //MARK: - Model
    var userInfo: User = User(id: "123123123", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false)
    
    lazy var testUser1: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                                  User(id: "12312312123", studentID: "32200956", gender: .female, major: "경영학과", readyState: false),
                                  User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                                  User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false)]
    
    let testUser2: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false)]
    
    let testUser3: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false)]
    
    let testUser4: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "1442", studentID: "32220956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312312123", studentID: "32200956", gender: .female, major: "경영학과", readyState: false),
                             User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false),
                             User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false),
                             User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false)]
    
    let testUser5: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "1442", studentID: "32220956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312312123", studentID: "32200956", gender: .female, major: "경영학과", readyState: false),
                             User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false),
                             User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false),
                             User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false)]
    
    let testUser6: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "1442", studentID: "32220956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312312123", studentID: "32200956", gender: .female, major: "경영학과", readyState: false),
                             User(id: "12312343123", studentID: "32180956", gender: .male, major: "전자전기공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false),
                             User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false)]
    
    let testUser7: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "1442", studentID: "32220956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false),
                             User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false)]
    
    let testUser8: [User] = [User(id: "1231231233", studentID: "32190956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "1442", studentID: "32220956", gender: .male, major: "기계공학과", readyState: false),
                             User(id: "12312223123", studentID: "32240956", gender: .female, major: "화학공학과", readyState: false),
                             User(id: "12312355123", studentID: "32230956", gender: .female, major: "경영학과", readyState: false)]
    
    lazy var roomList: [Room]? = [Room(title: "진짜 술고래들만 들어와라", subTitle: "이거 보여주려고 어그로 끌었다 미안하다...", participants:                          self.testUser1, maxParticipants: 6),
                             Room(title: "공대 차은우입니다.", subTitle: "카리나 구합니다. 윈터도 괜찮습니다.", participants: self.testUser2, maxParticipants: 4),
                             Room(title: "친구 만들사람~~~🤗", subTitle: "mbti 극I인 사람들 우리도 친구 만들어보자!!!", participants: self.testUser3, maxParticipants: 6),
                             Room(title: "군 필 신 입 생", subTitle: "군필 신입생. 더 이상 무슨 말이 필요하죠?", participants: self.testUser4, maxParticipants: 8),
                             Room(title: "여기 비쥬얼 연애대상", subTitle: "저희는 외모 안봐요. 성격 좋은 남자분들, 재밌는 남자분들 들어오세욥", participants: self.testUser5, maxParticipants: 8),
                             Room(title: "고인물도 과팅하자", subTitle: "18-21학번까지만 받겠습니다. 고인물도 사랑을 찾고 싶어요", participants: self.testUser6, maxParticipants: 6),
                             Room(title: "이성 친구 만들 사람은 들어와", subTitle: "남고 여고출신이라 이성 친구가 없는 사람 환영해요", participants: self.testUser7, maxParticipants: 4),
                             Room(title: "단국 뉴진스 만날사람", subTitle: "유유유유유유유유유~~~ 매그네~~~~릭", participants: self.testUser8, maxParticipants: 4)]
        
    var room: Room?
    
    func makeUserInfo(student_no: String, gender: String, major: String) {
       
    }
    
    
    func postUserInfo() {
        
    }
    
    
    
    
}
