//
//  StandbyVC2.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit
import SnapKit
import Then


final class StandbyVC2: StandbyViewController {
    //MARK: - Properties
    private lazy var firstUserStackView = UIStackView(arrangedSubviews: [firstUserImageButton, firstUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var secondUserStackView = UIStackView(arrangedSubviews: [secondUserImageButton, secondUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var thirdUserStackView = UIStackView(arrangedSubviews: [thirdUserImageButton, thirdUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var fourthUserStackView = UIStackView(arrangedSubviews: [fourthUserImageButton, fourthUserNameLabel]).then {
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
    
    private lazy var buttons = [self.firstUserImageButton, self.secondUserImageButton,
                                self.thirdUserImageButton, self.fourthUserImageButton]
    
    lazy var firstInfoView = InfoView().then { $0.isHidden = true }
    lazy var secondInfoView = InfoView().then { $0.isHidden = true }
    lazy var thirdInfoView = InfoView().then { $0.isHidden = true }
    lazy var fourthInfoView = InfoView().then { $0.isHidden = true }
    
    var myViewModel = MyViewModel() {
        didSet {
            guard let room = self.myViewModel.room else { return }
            self.configureUIWithData(room: room)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC2()
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
        guard let room = myViewModel.room else { return }
        let participants = room.participants
        
    }
    
    
}


extension StandbyVC2: StandbyInformation {
    
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
        default:
            break
        }
    }
    

    private func configureStandyVC2() {
        self.view.addSubviews(firstUserStackView, secondUserStackView,
                              thirdUserStackView, fourthUserStackView,
                              firstInfoView, secondInfoView,
                              thirdInfoView, fourthInfoView)
        
        self.firstUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(55)
            $0.top.equalToSuperview().offset(257)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.secondUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-55)
            $0.top.equalToSuperview().offset(257)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.thirdUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(55)
            $0.top.equalToSuperview().offset(457)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.fourthUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-55)
            $0.top.equalToSuperview().offset(457)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.firstInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.firstUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.bottom.equalTo(self.firstUserImageButton.snp.top).offset(-8)
        }
        
        self.secondInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.secondUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.bottom.equalTo(self.secondUserImageButton.snp.top).offset(-8)
        }
        
        self.thirdInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.thirdUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.top.equalTo(self.thirdUserNameLabel.snp.bottom).offset(8)
        }
        
        self.fourthInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.fourthUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.top.equalTo(self.fourthUserNameLabel.snp.bottom).offset(8)
        }
        
    }
    private func settingActionsForImageButton() {
        self.buttons.forEach {
            $0.addTarget(self, action: #selector(userButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func settingCornerRadiusForInfoView() {
        self.firstInfoView.roundCorners(topLeft: 25.5, topRight: 25, bottomRight: 25)
        self.secondInfoView.roundCorners(topLeft: 25, topRight: 25.5, bottomLeft: 25)
        self.thirdInfoView.roundCorners(topRight: 25, bottomLeft: 25.5, bottomRight: 25)
        self.fourthInfoView.roundCorners(topLeft: 25, bottomLeft: 25 ,bottomRight: 25.5)
    }
    
    private func configureUIWithData(room: Room) {
        let participants = room.participants
        let males = participants.filter{$0.gender == "male"}
        let females = participants.filter{$0.gender == "female"}
        
        let maleInfoView = [self.firstInfoView, self.secondInfoView]
        let femaleInfoView = [self.thirdInfoView, self.fourthInfoView]
        
        updateInfoView(infoViews: maleInfoView, users: males)
        updateInfoView(infoViews: femaleInfoView, users: females)
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
    
}
