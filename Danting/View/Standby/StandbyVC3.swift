//
//  StandbyVC3.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit

final class StandbyVC3: StandbyViewController {
    //MARK: - Properties
    private lazy var firstUserStackView = UIStackView(arrangedSubviews: [firstUserImageButton, firstUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var firstUserImageButton = UIButton().then {
        $0.setImage(UIImage(named: "unready.png"), for: .normal)
        $0.tag = 1
    }
    
    private lazy var firstUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var secondUserStackView = UIStackView(arrangedSubviews: [secondUserImageButton, secondUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var secondUserImageButton = UIButton().then {
        $0.setImage(UIImage(named: "unready.png"), for: .normal)
        $0.tag = 2
    }
    
    private lazy var secondUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var thirdUserStackView = UIStackView(arrangedSubviews: [thirdUserImageButton, thirdUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var thirdUserImageButton = UIButton().then {
        $0.setImage(UIImage(named: "unready.png"), for: .normal)
        $0.tag = 3
    }
    
    private lazy var thirdUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var fourthUserStackView = UIStackView(arrangedSubviews: [fourthUserImageButton, fourthUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    private lazy var fourthUserImageButton = UIButton().then {
        $0.setImage(UIImage(named: "unready.png"), for: .normal)
        $0.tag = 4
    }
    
    private lazy var fourthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var fifthUserStackView = UIStackView(arrangedSubviews: [fifthUserImageButton, fifthUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    private lazy var fifthUserImageButton = UIButton().then {
        $0.setImage(UIImage(named: "unready.png"), for: .normal)
        $0.tag = 5
    }
    
    private lazy var fifthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var sixthUserStackView = UIStackView(arrangedSubviews: [sixthUserImageButton, sixthUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    private lazy var sixthUserImageButton = UIButton().then {
        $0.setImage(UIImage(named: "unready.png"), for: .normal)
        $0.tag = 6
    }
    
    private lazy var sixthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    
    private lazy var buttons = [self.firstUserImageButton, self.secondUserImageButton,
                                self.thirdUserImageButton, self.fourthUserImageButton,
                                self.fifthUserImageButton, self.sixthUserImageButton]
    
    lazy var firstInfoView = InfoView().then { $0.isHidden = true }
    lazy var secondInfoView = InfoView().then { $0.isHidden = true }
    lazy var thirdInfoView = InfoView().then { $0.isHidden = true }
    lazy var fourthInfoView = InfoView().then { $0.isHidden = true }
    lazy var fifthInfoView = InfoView().then { $0.isHidden = true }
    lazy var sixthInfoView = InfoView().then { $0.isHidden = true }
    
    var myViewModel = MyViewModel() {
        didSet {
            guard let room = self.myViewModel.room else { return }
            self.configureUIWithData(room: room)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC3()
        self.settingActionsForImageButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.settingCornerRadiusForInfoView()
    }
    
    @objc func userButtonTapped(_ sender: UIButton) {

        self.presentInfoView(tag: sender.tag)
        // 준비완료시 서버로 상태 전달
    }
    override func readyButtonDidTapped(_ sender: UIButton) {
        //1안대로 간다면, 준비를 하지 않은 상태에서 준비를 누르면, 바뀐 준비 상태인 isReady == true 의 값을 result로 받음
        guard let user_id = UserDefaults.standard.string(forKey: "user_id"), !user_id.isEmpty,
              let room_id = self.myViewModel.room?.room_id else { return }
        APIService.shared.ready(user_id: Int(user_id) ?? 0, room_id: Int(room_id) ?? 0 ) { response in
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
    private func settingActionsForImageButton() {
        self.buttons.forEach {
            $0.addTarget(self, action: #selector(userButtonTapped(_:)), for: .touchUpInside)
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
    
    
    private func configureUIWithData(room: Room) {
        let participants = room.participants
        let males = participants.filter{$0.gender == "male"}
        let females = participants.filter{$0.gender == "female"}
        
        let maleInfoView = [self.firstInfoView, self.secondInfoView, self.thirdInfoView]
        let femaleInfoView = [self.fourthInfoView, self.fifthInfoView, self.sixthInfoView]
        
        let maleNameView = [self.firstUserNameLabel, self.secondUserNameLabel, self.thirdUserNameLabel]
        let femaleNameView = [self.fourthUserNameLabel, self.fifthUserNameLabel, self.sixthUserNameLabel]
        
        updateInfoView(infoViews: maleInfoView, users: males)
        updateInfoView(infoViews: femaleInfoView, users: females)
        
        updateUserNameView(nameLabels: maleNameView, users: males)
        updateUserNameView(nameLabels: femaleNameView, users: females)
    }
    
    private func updateInfoView(infoViews: [InfoView], users: [User]) {
        // InfoView와 users의 개수만큼 업데이트
        for (index, user) in users.enumerated() where index < infoViews.count {
            let infoView = infoViews[index]
            infoView.isHidden = false
            infoView.updateWithData(studentID: user.student_no, major: user.major)
        }
        
        // 남은 InfoView는 숨김 처리
        for index in users.count..<infoViews.count {
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
    
}
