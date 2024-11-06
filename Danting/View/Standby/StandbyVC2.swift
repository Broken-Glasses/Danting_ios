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
    private lazy var firstUserStackView = UIStackView(arrangedSubviews: [firstUserImageButton, firstUserNameLabel])
    private lazy var secondUserStackView = UIStackView(arrangedSubviews: [secondUserImageButton, secondUserNameLabel])
    private lazy var thirdUserStackView = UIStackView(arrangedSubviews: [thirdUserImageButton, thirdUserNameLabel])
    private lazy var fourthUserStackView = UIStackView(arrangedSubviews: [fourthUserImageButton, fourthUserNameLabel])
    
    

    private let firstUserImageButton = UIButton()
    private let secondUserImageButton = UIButton()
    private let thirdUserImageButton = UIButton()
    private let fourthUserImageButton = UIButton()

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

    private lazy var firstInfoView = InfoView().then { $0.isHidden = true }
    private lazy var secondInfoView = InfoView().then { $0.isHidden = true }
    private lazy var thirdInfoView = InfoView().then { $0.isHidden = true }
    private lazy var fourthInfoView = InfoView().then { $0.isHidden = true }
    
    private lazy var maleInfoView = [self.firstInfoView, self.secondInfoView]
    private lazy var maleNameLabel = [self.firstUserNameLabel, self.secondUserNameLabel]
    
    private lazy var femaleInfoView = [self.thirdInfoView, self.fourthInfoView]
    private lazy var femaleNameLabel = [self.thirdUserNameLabel, self.fourthUserNameLabel]
    
    private lazy var userStackViews = [self.firstUserStackView, self.secondUserStackView, self.thirdUserStackView, self.fourthUserStackView]
    
    
    private lazy var userImageButtons = [self.firstUserImageButton, self.secondUserImageButton,
                                         self.thirdUserImageButton, self.fourthUserImageButton]
        
    private var refreshTimer: Timer?
    private let interval: TimeInterval = 2 // 2초마다 GET 요청을 보냅니다.
    private var willRepeat: Bool? = true
    
    var myViewModel = MyViewModel() {
        didSet {
            guard let room = self.myViewModel.room else { return }
            self.configureUIWithData(roomDetailResponse: room)
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC2()
        self.settingUserImageButton()
        self.settingUserStackView()
        self.repeatRequest()
        //self.updateUI()
        // 서버로 주기적으로 변경사항을 요청 주석 풀면 작동
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
        let roomId = room.room_id
        
        self.myViewModel.apiService.getRoom(roomId: roomId) { serverResponse in
            switch serverResponse {
            case .success(let roomDetailResponse):
                let roomDetailResponse = roomDetailResponse.result
                self.configureUIWithData(roomDetailResponse: roomDetailResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func readyButtonDidTapped(_ sender: UIButton) {

        //1안대로 간다면, 준비를 하지 않은 상태에서 준비를 누르면, 바뀐 준비 상태인 isReady == true 의 값을 result로 받음

        guard let rooId = self.myViewModel.room?.room_id,
              let users_id = UserDefaults.standard.value(forKey: userIdKey) as? Int else { return }
        
        self.myViewModel.ready(users_id: users_id, roomId: rooId) { buttonState in
            self.configureButtonState(sender: sender, isReady: buttonState)
        }
        
        
    }
}


extension StandbyVC2: RequestForOpenKakao {
    
    func repeatRequest() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
                guard let self = self,
                      let willRepeat = self.willRepeat,
                    let roomId = self.myViewModel.room?.room_id else { return }
                
                // willRepeat가 true일 때만 requestReadyState 호출
                if willRepeat {
                    self.requestReadyState(roomId: roomId)
                } else {
                    // willRepeat가 false가 되면 타이머를 중지
                    timer.invalidate()
                }
            }
    }
    func requestReadyState(roomId: Int) {
        self.myViewModel.apiService.getRoom(roomId: roomId) { roomDetailResponse in
            switch roomDetailResponse {
            case .success(let detailResponse):
                print("success")
                let femaleParticipants = detailResponse.result.femaleParticipants
                let maleParticipants = detailResponse.result.maleParticipants
                let allReadyState = femaleParticipants.map{$0.ready} + maleParticipants.map{$0.ready}
                let ready = allReadyState.allSatisfy {$0 == true}
                if ready {
                    self.willRepeat = false
                    
                    let openKakaoVC = PopupViewController()
                    openKakaoVC.modalPresentationStyle = .overFullScreen
                    let views = self.generateViewsForOpenKakao()
                    openKakaoVC.addSubviewsToStackView(views: views) {
                        DispatchQueue.main.async {
                            self.present(openKakaoVC, animated: true)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - StandbyInformation
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
    
    private func configureUIWithData(roomDetailResponse: RoomDetailResponse) {
        let maleParticipants = roomDetailResponse.maleParticipants
        let femaleParticipants = roomDetailResponse.femaleParticipants
        
        self.updateInfoView(infoViews: self.maleInfoView, participants: maleParticipants)
        self.updateInfoView(infoViews: self.femaleInfoView, participants: femaleParticipants)
        
        self.updateUserNameView(nameLabels: self.maleNameLabel, users: maleParticipants)
        self.updateUserNameView(nameLabels: self.femaleNameLabel, users: femaleParticipants)
    }
    
    private func updateInfoView(infoViews: [InfoView], participants: [RoomDetailUserResponse]) {
        for (index, user) in participants.enumerated() where index < infoViews.count {
            let infoView = infoViews[index]
            infoView.isHidden = false
            infoView.updateWithData(studentID: user.student_no, major: user.major)
        }
        
        for index in participants.count..<infoViews.count {
            infoViews[index].isHidden = true
        }
    }
    
    private func updateUserNameView(nameLabels: [UILabel], users: [RoomDetailUserResponse]) {
        for (index, user) in users.enumerated() where index < nameLabels.count {
            let nameLabel = nameLabels[index]
            nameLabel.text = user.nickName
            nameLabel.isHidden = false
        }
        
        for index in users.count..<nameLabels.count {
            nameLabels[index].text = ""
        }
    }
    
    private func configureStandyVC2() {
        self.view.addSubviews(firstUserStackView, secondUserStackView, thirdUserStackView, fourthUserStackView,
                              firstInfoView, secondInfoView, thirdInfoView, fourthInfoView)
        
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
        self.secondInfoView.roundCorners(topLeft: 25, topRight: 25.5, bottomLeft: 25)
        self.thirdInfoView.roundCorners(topRight: 25, bottomLeft: 25.5, bottomRight: 25)
        self.fourthInfoView.roundCorners(topLeft: 25, bottomLeft: 25 ,bottomRight: 25.5)
    }
}
