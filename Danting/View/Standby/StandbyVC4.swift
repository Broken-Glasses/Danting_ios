//
//  StandbyVC3.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit

final class StandbyVC4: StandbyViewController {
    //MARK: - Properties
    private lazy var firstUserStackView = UIStackView(arrangedSubviews: [firstUserImageButton, firstUserNameLabel])
    private lazy var secondUserStackView = UIStackView(arrangedSubviews: [secondUserImageButton, secondUserNameLabel])
    private lazy var thirdUserStackView = UIStackView(arrangedSubviews: [thirdUserImageButton, thirdUserNameLabel])
    private lazy var fourthUserStackView = UIStackView(arrangedSubviews: [fourthUserImageButton, fourthUserNameLabel])
    private lazy var fifthUserStackView = UIStackView(arrangedSubviews: [fifthUserImageButton, fifthUserNameLabel])
    private lazy var sixthUserStackView = UIStackView(arrangedSubviews: [sixthUserImageButton, sixthUserNameLabel])
    private lazy var seventhUserStackView = UIStackView(arrangedSubviews: [seventhUserImageButton, seventhUserNameLabel])
    private lazy var eighthUserStackView = UIStackView(arrangedSubviews: [eighthUserImageButton, eighthUserNameLabel])
    
    private lazy var firstUserImageButton = UIButton()
    private lazy var secondUserImageButton = UIButton()
    private lazy var thirdUserImageButton = UIButton()
    private lazy var fourthUserImageButton = UIButton()
    private lazy var fifthUserImageButton = UIButton()
    private lazy var sixthUserImageButton = UIButton()
    private lazy var seventhUserImageButton = UIButton()
    private lazy var eighthUserImageButton = UIButton()
    
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

    private lazy var seventhUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var eighthUserNameLabel = UILabel().then {
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
    lazy var seventhInfoView = InfoView().then { $0.isHidden = true }
    lazy var eightInfoView = InfoView().then { $0.isHidden = true }
    
    private lazy var maleInfoView = [self.firstInfoView, self.secondInfoView, self.thirdInfoView, self.fourthInfoView]
    private lazy var maleNameLabel = [self.firstUserNameLabel, self.secondUserNameLabel, thirdUserNameLabel, self.fourthUserNameLabel]
    
    private lazy var femaleInfoView = [self.fifthInfoView, self.sixthInfoView, self.seventhInfoView, self.eightInfoView]
    private lazy var femaleNameLabel = [self.fifthUserNameLabel, self.sixthUserNameLabel, self.seventhUserNameLabel, self.eighthUserNameLabel]
    
    private lazy var userStackViews = [self.firstUserStackView, self.secondUserStackView, self.thirdUserStackView,
                                       self.fourthUserStackView, self.fifthUserStackView, self.sixthUserStackView, self.seventhUserStackView, self.eighthUserStackView]
    
    
    
    
    
    private lazy var userImageButtons = [self.firstUserImageButton, self.secondUserImageButton,
                                self.thirdUserImageButton, self.fourthUserImageButton,
                                self.fifthUserImageButton, self.sixthUserImageButton,
                                self.seventhUserImageButton, self.eighthUserImageButton]
    
    private var refreshTimer: Timer?
    private let interval: TimeInterval = 10 // 10초마다 GET 요청을 보냅니다.
    private var willRepeat: Bool?

//    var myViewModel = MyViewModel() {
//        didSet {
//            guard let room = self.myViewModel.room else { return }
//            self.configureUIWithData(room: room)
//        }
//    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC4()
        self.settingUserStackView()
        self.settingUserImageButton()
        self.repeatRequest()
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
            /*switch response {
            case .success(let room):
                // 받은 데이터를 사용하여 화면 갱신
                //self.configureUIWithData(room: room)
            case .failure(let error):
                print("Failed to fetch data: \(error)")
            }*/
        }

    }
    
    override func readyButtonDidTapped(_ sender: UIButton) {
        //1안대로 간다면, 준비를 하지 않은 상태에서 준비를 누르면, 바뀐 준비 상태인 isReady == true 의 값을 result로 받음
        guard let user_id = UserDefaults.standard.value(forKey: "user_id") as? Int,
              let room_id = self.myViewModel.room?.room_id else { return }
        /*APIService.shared.ready(m_id: user_id, room_id: room_id) { response in
            switch response {
            case .success(let isReady):
                print(isReady)
                self.configureButtonState(sender: sender, isReady: isReady)
            case .failure(let error):
                print(error)
            }
        }*/
    }
}

extension StandbyVC4: RequestForOpenKakao {
    
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
        self.myViewModel.apiService.getRoom(room_id: roomId) { roomDetailResponse in
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

extension StandbyVC4: StandbyInformation {

    
  
    
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
        case 7:
            seventhInfoView.isHidden.toggle()
        case 8:
            eightInfoView.isHidden.toggle()
        default:
            break
        }
    }
    
    
    
    private func configureUIWithData(room: RoomDetailResponse) {
        let maleParticipants = room.maleParticipants
        let femaleParticipants = room.femaleParticipants

        print("Debug: 남성 참가자 == \(maleParticipants)")
        print("\n")
        print("Debug: 여성 참가자 == \(femaleParticipants)")
        
//        self.updateInfoView(infoViews: self.maleInfoView, participants: maleParticipants)
//        self.updateInfoView(infoViews: self.femaleInfoView, participants: femaleParticipants)
//        
//        self.updateUserNameView(nameLabels: self.maleNameLabel, users: maleParticipants)
//        self.updateUserNameView(nameLabels: self.femaleNameLabel, users: femaleParticipants)
    }
    
    private func updateInfoView(infoViews: [InfoView], participants: [RoomDetailUserResponse]) {
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
    
    private func updateUserNameView(nameLabels: [UILabel], users: [RoomDetailUserResponse]) {
        // InfoView와 users의 개수만큼 업데이트
        for (index, user) in users.enumerated() where index < nameLabels.count {
//            nameLabel.text = user.nickName
            //nameLabel.isHidden = false
        }
        
        // 남은 InfoView는 숨김 처리
        for index in users.count..<nameLabels.count {
            nameLabels[index].text = ""
        }
    }
    private func configureStandyVC4() {
        self.view.addSubviews(firstUserStackView, secondUserStackView,
                              thirdUserStackView, fourthUserStackView,
                              fifthUserStackView, sixthUserStackView,
                              seventhUserStackView, eighthUserStackView,
                              firstInfoView, secondInfoView,
                              thirdInfoView, fourthInfoView,
                              fifthInfoView, sixthInfoView,
                              seventhInfoView, eightInfoView)
        
        self.firstUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(301)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.secondUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(100)
            $0.top.equalToSuperview().offset(225)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.thirdUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-100)
            $0.top.equalToSuperview().offset(225)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.fourthUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-24)
            $0.top.equalToSuperview().offset(301)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        
        
        self.fifthUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(411)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.sixthUserStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(100)
            $0.top.equalToSuperview().offset(495)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.seventhUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-100)
            $0.top.equalToSuperview().offset(495)
            $0.width.equalTo(67.35)
            $0.height.equalTo(84.42)
        }
        
        self.eighthUserStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-24)
            $0.top.equalToSuperview().offset(411)
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
            $0.bottom.equalTo(self.thirdUserImageButton.snp.top).offset(-8)
        }
        
        self.fourthInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.fourthUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.bottom.equalTo(self.fourthUserImageButton.snp.top).offset(-8)
        }
        
        
        
        self.fifthInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.fifthUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.top.equalTo(self.fifthUserNameLabel.snp.bottom).offset(8)
        }
        
        self.sixthInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.sixthUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.top.equalTo(self.sixthUserNameLabel.snp.bottom).offset(8)
        }
        
        self.seventhInfoView.snp.makeConstraints {
            $0.leading.equalTo(self.seventhUserImageButton.snp.leading)
            $0.height.equalTo(49)
            $0.top.equalTo(self.seventhUserNameLabel.snp.bottom).offset(8)
        }
        
        self.eightInfoView.snp.makeConstraints {
            $0.trailing.equalTo(self.eighthUserImageButton.snp.trailing)
            $0.height.equalTo(49)
            $0.top.equalTo(self.eighthUserNameLabel.snp.bottom).offset(8)
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
        self.thirdInfoView.roundCorners(topLeft: 25.5, topRight: 25, bottomRight: 25)
        self.fourthInfoView.roundCorners(topLeft: 25, topRight: 25.5, bottomLeft: 25)

        self.fifthInfoView.roundCorners(topRight: 25, bottomLeft: 25.5, bottomRight: 25)
        self.sixthInfoView.roundCorners(topLeft: 25, bottomLeft: 25 ,bottomRight: 25.5)
        self.seventhInfoView.roundCorners(topRight: 25, bottomLeft: 25.5, bottomRight: 25)
        self.eightInfoView.roundCorners(topLeft: 25, bottomLeft: 25 ,bottomRight: 25.5)
    }
}
