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
    // MARK: - Properties
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
    private lazy var userImageButtons = [self.firstUserImageButton, self.secondUserImageButton, self.thirdUserImageButton, self.fourthUserImageButton]
    
    private var refreshTimer: Timer?
    private let refreshInterval: TimeInterval = 2.0 // 2 seconds interval for fetching data
    private var willRepeat: Bool = true
    
    var myViewModel = MyViewModel() {
        didSet {
            guard let room = self.myViewModel.room else { return }
            self.configureUIWithData(roomDetailResponse: room)
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC2()
        self.settingUserImageButton()
        self.settingUserStackView()
        self.startPeriodicRoomRefresh()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopPeriodicRoomRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.settingCornerRadiusForInfoView()
    }
    
    // MARK: - Timer Methods
    private func startPeriodicRoomRefresh() {
        refreshTimer = Timer.scheduledTimer(timeInterval: refreshInterval, target: self, selector: #selector(fetchRoomData), userInfo: nil, repeats: true)
    }
    
    private func stopPeriodicRoomRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
    
    // MARK: - Data Fetching and Ready Check
    @objc private func fetchRoomData() {
        guard let roomId = myViewModel.room?.room_id else { return }
        
        self.myViewModel.apiService.getRoom(roomId: roomId) { [weak self] serverResponse in
            DispatchQueue.main.async {
                switch serverResponse {
                case .success(let roomDetailResponse):
                    let roomDetail = roomDetailResponse.result
                    self?.configureUIWithData(roomDetailResponse: roomDetail)
                    self?.checkIfAllReady(roomDetail: roomDetail)
                case .failure(let error):
                    print("Failed to fetch room data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func checkIfAllReady(roomDetail: RoomDetailResponse) {
        let allReady = (roomDetail.maleParticipants + roomDetail.femaleParticipants).allSatisfy { $0.ready }
        
        if allReady && willRepeat {
            willRepeat = false // Stop further checks once everyone is ready
            showOpenKakaoVC()
            stopPeriodicRoomRefresh() // Stop the timer since we no longer need updates
        }
    }
    
    private func showOpenKakaoVC() {
        let openKakaoVC = PopupViewController()
        openKakaoVC.modalPresentationStyle = .overFullScreen
        let views = self.generateViewsForOpenKakao()
        openKakaoVC.addSubviewsToStackView(views: views) {
            DispatchQueue.main.async {
                self.present(openKakaoVC, animated: true)
            }
        }
    }
    
    // MARK: - Actions
    @objc func userButtonTapped(_ sender: UIButton) {
        self.presentInfoView(tag: sender.tag)
    }
    
    override func readyButtonDidTapped(_ sender: UIButton) {
        guard let room = self.myViewModel.room,
              let users_id = UserDefaults.standard.value(forKey: userIdKey) as? Int else { return }
        
        let roomId = room.room_id
        
        let allParticipants = room.maleParticipants + room.femaleParticipants
        
        if let participant = allParticipants.first(where: { $0.users_id == users_id }) {
            
            let readyStatus = participant.ready
            
            if readyStatus {
                self.myViewModel.unready(users_id: users_id, room_id: roomId) { buttonState in
                    DispatchQueue.main.async {
                        self.configureButtonState(sender: sender, isReady: false)
                    }
                }
            } else {
                self.myViewModel.ready(users_id: users_id, room_id: roomId) { buttonState in
                    DispatchQueue.main.async {
                        self.configureButtonState(sender: sender, isReady: true)
                    }
                }
            }
        } else {
            print("User with ID \(users_id) not found in room participants.")
        }
    }
    
    // MARK: - UI Configuration
    private func configureUIWithData(roomDetailResponse: RoomDetailResponse) {
        self.myViewModel.room = roomDetailResponse
        
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
        self.fourthInfoView.roundCorners(topLeft: 25, bottomLeft: 25, bottomRight: 25.5)
    }
}

extension StandbyVC2: RequestForOpenKakao {
    func repeatRequest() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
            guard let self = self,
                  self.willRepeat,
                  let roomId = self.myViewModel.room?.room_id else { return }
            
            if self.willRepeat {
                self.requestReadyState(roomId: roomId)
            } else {
                timer.invalidate()
            }
        }
    }
    
    func requestReadyState(roomId: Int) {
        self.myViewModel.getRoomDetail(roomId: roomId) { detailResponse in
            let femaleParticipants = detailResponse.femaleParticipants
            let maleParticipants = detailResponse.maleParticipants
            let allReadyState = femaleParticipants.map { $0.ready } + maleParticipants.map { $0.ready }
            let isFull = (femaleParticipants + maleParticipants).count == detailResponse.maxParticipants
            
            let ready = allReadyState.allSatisfy { $0 == true } && isFull
            
            if ready {
                self.willRepeat = false
                self.showOpenKakaoVC()
            }
        }
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
}


