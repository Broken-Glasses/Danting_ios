//
//  StandbyVC3.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit

final class StandbyVC3: StandbyViewController {
    //MARK: - Properties
    private lazy var firstUserStackView = UIStackView(arrangedSubviews: [firstUserImageButton, firstUserNameLabel])
    private lazy var secondUserStackView = UIStackView(arrangedSubviews: [secondUserImageButton, secondUserNameLabel])
    private lazy var thirdUserStackView = UIStackView(arrangedSubviews: [thirdUserImageButton, thirdUserNameLabel])
    private lazy var fourthUserStackView = UIStackView(arrangedSubviews: [fourthUserImageButton, fourthUserNameLabel])
    private lazy var fifthUserStackView = UIStackView(arrangedSubviews: [fifthUserImageButton, fifthUserNameLabel])
    private lazy var sixthUserStackView = UIStackView(arrangedSubviews: [sixthUserImageButton, sixthUserNameLabel])
    
    private lazy var firstUserImageButton = UIButton()
    private lazy var secondUserImageButton = UIButton()
    private lazy var thirdUserImageButton = UIButton()
    private lazy var fourthUserImageButton = UIButton()
    private lazy var fifthUserImageButton = UIButton()
    private lazy var sixthUserImageButton = UIButton()
    
    private lazy var firstUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var secondUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var thirdUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }

    private lazy var fourthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var fifthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var sixthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    lazy var firstInfoView = InfoView().then { $0.isHidden = true }
    lazy var secondInfoView = InfoView().then { $0.isHidden = true }
    lazy var thirdInfoView = InfoView().then { $0.isHidden = true }
    lazy var fourthInfoView = InfoView().then { $0.isHidden = true }
    lazy var fifthInfoView = InfoView().then { $0.isHidden = true }
    lazy var sixthInfoView = InfoView().then { $0.isHidden = true }
    
    private lazy var maleInfoView = [self.firstInfoView, self.secondInfoView, self.thirdInfoView]
    private lazy var maleNameLabel = [self.firstUserNameLabel, self.secondUserNameLabel, thirdUserNameLabel]
    
    private lazy var femaleInfoView = [self.fourthInfoView, self.fifthInfoView, self.sixthInfoView]
    private lazy var femaleNameLabel = [self.fourthUserNameLabel, self.fifthUserNameLabel, self.sixthUserNameLabel]
    
    private lazy var userStackViews = [self.firstUserStackView, self.secondUserStackView, self.thirdUserStackView,
                                       self.fourthUserStackView, self.fifthUserStackView, self.sixthUserStackView]
    
    private lazy var userImageButtons = [self.firstUserImageButton, self.secondUserImageButton,self.thirdUserImageButton,
                                         self.fourthUserImageButton,self.fifthUserImageButton, self.sixthUserImageButton]
   

    private var refreshTimer: Timer?
    private let interval: TimeInterval = 10 // 10초마다 GET 요청을 보냅니다.
    
    var myViewModel = MyViewModel() {
        didSet {
            guard let room = self.myViewModel.room else { return }
            self.configureUIWithData(room: room)
        }
    }

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC3()
        self.settingUserImageButton()
        self.settingUserStackView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.settingCornerRadiusForInfoView()
    }
    
    //MARK: - Helpers
    private func updateUI() {
        refreshTimer = Timer.scheduledTimer(timeInterval: interval, target: self,
                                            selector: #selector(fetchDataAndRefresh),
                                            userInfo: nil, repeats: true)
    }
    
    //MARK: - Actions
    @objc func userButtonTapped(_ sender: UIButton) {
        self.presentInfoView(tag: sender.tag)
    }
    
    @objc func fetchDataAndRefresh() {
        guard let room = myViewModel.room else { return }
        APIService.shared.getRoom(room_id: room.room_id) { response in
            switch response {
            case .success(let room):
                // 받은 데이터를 사용하여 화면 갱신
                self.configureUIWithData(room: room)
            case .failure(let error):
                print("Failed to fetch data: \(error)")
            }
        }
    }
    
    override func readyButtonDidTapped(_ sender: UIButton) {
        //1안대로 간다면, 준비를 하지 않은 상태에서 준비를 누르면, 바뀐 준비 상태인 isReady == true 의 값을 result로 받음
        guard let user_id = UserDefaults.standard.value(forKey: "user_id") as? Int,
              let room_id = self.myViewModel.room?.room_id else { return }
        APIService.shared.ready(user_id: user_id, room_id: room_id) { response in
            switch response {
            case .success(let isReady):
                print(isReady)
                self.configureButtonState(sender: sender, isReady: isReady)
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension StandbyVC3: StandbyInformation {

    func presentInfoView(tag: Int) {
        switch tag {
        case 1:
            firstInfoView.isHidden.toggle()
        case 2:
            secondInfoView.isHidden.toggle()
        case 3:
            thirdInfoView.isHidden.toggle()
        case 4:
            fourthInfoView.isHidden.toggle()
        case 5:
            fifthInfoView.isHidden.toggle()
        case 6:
            sixthInfoView.isHidden.toggle()
        default:
            break
        }
    }
    
    
    private func configureUIWithData(room: Room) {
        let maleParticipants = room.maleParticipants
        let femaleParticipants = room.femaleParticipants

        print("Debug: 남성 참가자 == \(maleParticipants)")
        print("\n")
        print("Debug: 여성 참가자 == \(femaleParticipants)")
        
        self.updateInfoView(infoViews: self.maleInfoView, participants: maleParticipants)
        self.updateInfoView(infoViews: self.femaleInfoView, participants: femaleParticipants)
        
        self.updateUserNameView(nameLabels: self.maleNameLabel, users: maleParticipants)
        self.updateUserNameView(nameLabels: self.femaleNameLabel, users: femaleParticipants)
    }
    
    private func updateInfoView(infoViews: [InfoView], participants: [User]) {
        // InfoView와 users의 개수만큼 업데이트
        for (index, user) in participants.enumerated() where index < infoViews.count {
            let infoView = infoViews[index]
            infoView.isHidden = false
            infoView.updateWithData(studentID: user.student_no, major: user.major)
        }
        
        // 남은 InfoView는 숨김 처리
        for index in participants.count..<infoViews.count {
            infoViews[index].isHidden = true
        }
    }
    
    private func updateUserNameView(nameLabels: [UILabel], users: [User]) {
        // InfoView와 users의 개수만큼 업데이트
        for (index, user) in users.enumerated() where index < nameLabels.count {
            let nameLabel = nameLabels[index]
            nameLabel.text = user.nickName
            nameLabel.isHidden = false
        }
        
        // 남은 InfoView는 숨김 처리
        for index in users.count..<nameLabels.count {
            nameLabels[index].text = ""
        }
    }
    private func configureStandyVC3() {
        self.view.addSubviews(firstUserStackView, secondUserStackView,
                              thirdUserStackView, fourthUserStackView,
                              fifthUserStackView, sixthUserStackView,
                              firstInfoView, secondInfoView,
                              thirdInfoView, fourthInfoView,
                              fifthInfoView, sixthInfoView)
        
        self.firstUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(42)
            $0.top.equalToSuperview().offset(274)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.secondUserStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(210)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.thirdUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-42)
            $0.top.equalToSuperview().offset(274)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.fourthUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(42)
            $0.top.equalToSuperview().offset(447)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.fifthUserStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(508)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.sixthUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-42)
            $0.top.equalToSuperview().offset(447)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.firstInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.firstUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.bottom.equalTo(self.firstUserImageButton.snp.top).offset(-8)
        }
        
        self.secondInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.secondUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.bottom.equalTo(self.secondUserImageButton.snp.top).offset(-8)
        }
        
        self.thirdInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.thirdUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.bottom.equalTo(self.thirdUserImageButton.snp.top).offset(-8)
        }
        
        self.fourthInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.fourthUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.top.equalTo(self.fourthUserNameLabel.snp.bottom).offset(8)
        }
        
        self.fifthInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.fifthUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.top.equalTo(self.fifthUserNameLabel.snp.bottom).offset(8)
        }
        
        self.sixthInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.sixthUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.top.equalTo(self.sixthUserNameLabel.snp.bottom).offset(8)
        }
        
        
        
    }
    private func settingUserImageButton() {
        
        for (index, button) in self.userImageButtons.enumerated() {
            button.addTarget(self, action: #selector(userButtonTapped(_:)), for: .touchUpInside)
            button.setImage(UIImage(named: "unready.png"), for: .normal)
            button.tag = index + 1
        }
        
    }
    
    
    private func settingUserStackView() {
        self.userStackViews.forEach {
            $0.backgroundColor = .clear
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 4
        }
    }
    private func settingCornerRadiusForInfoView() {
        self.firstInfoView.roundCorners(topLeft: 25.5, topRight: 25, bottomRight: 25)
        self.secondInfoView.roundCorners(topLeft: 25.5, topRight: 25, bottomRight: 25)
        self.thirdInfoView.roundCorners(topLeft: 25, topRight: 25.5, bottomLeft: 25)
        
        self.fourthInfoView.roundCorners(topRight: 25, bottomLeft: 25.5 ,bottomRight: 25)
        self.fifthInfoView.roundCorners(topLeft: 25, bottomLeft: 25, bottomRight: 25.5)
        self.sixthInfoView.roundCorners(topLeft: 25, bottomLeft: 25 ,bottomRight: 25.5)
    }
    
    
   
}
