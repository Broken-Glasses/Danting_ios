import UIKit
import SnapKit

final class RoomListViewController: UIViewController {
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(named: "ic_plus"), for: .normal) // 이미지 설정
        button.layer.cornerRadius = 27.5 // 버튼의 반지름을 크기에 맞게 설정
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.imageView?.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(floatingButtonTapped(_:)), for: .touchUpInside)
        return button
    }()


    private lazy var roomListTableView = UITableView().then {
        $0.frame = self.view.bounds
        $0.delegate = self
        $0.dataSource = self
        $0.register(RoomItemCell.self, forCellReuseIdentifier: "RoomItemCell")
        
        $0.separatorStyle = .none
        $0.rowHeight = 100
        $0.estimatedRowHeight = 100
    }
    
    var myViewModel: MyViewModel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myViewModel = MyViewModel()
        self.configureRoomListVC()
        
    }
    
    //MARK: - Helpers
    private func fetchRoomList() {
        let apiService = APIService.shared
        apiService.getRooms { response in
            switch response {
            case .success(let rooms):
                self.myViewModel.roomList = rooms
            case .failure(let error):
                print(error)
            }
        }
    }
        
    //MARK: - Actions
    @objc func floatingButtonTapped(_ sender: UIButton) {
        let registerRoomVC = RegisterRoomVC()
        self.navigationController?.pushViewController(registerRoomVC, animated: true)
    }
}

extension RoomListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let roomlist = self.myViewModel.roomList else { return 0 }
        return roomlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //prepareForReuse 사용하기
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomItemCell", for: indexPath) as! RoomItemCell
        cell.selectionStyle = .none
        guard let roomList = self.myViewModel.roomList else { return cell }
        let room = roomList[indexPath.row]
        let maxParticipants = room.maxParticipants
        cell.roomItemView.titleLabel.text = room.title
        cell.roomItemView.subtitleLabel.text = room.subTitle
        cell.roomItemView.blueHeartLabel.text = String(room.participants.filter{$0.gender == "male"}.count) + "/" + String(maxParticipants/2)
        cell.roomItemView.redHeartLabel.text = String(room.participants.filter{$0.gender == "female"}.count) + "/" + String(maxParticipants/2)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let roomList = self.myViewModel.roomList else { return }
        let room = roomList[indexPath.row]
        self.myViewModel.room = room
        let views = self.generateViewsForRoomListPopupVC(room: room)
    
        let attendingVC = PopupViewController()
        attendingVC.modalPresentationStyle = .overFullScreen
        attendingVC.addSubviewsToStackView(views: views) {
            attendingVC.myViewModel = self.myViewModel
            self.present(attendingVC, animated: true, completion: nil)
        }
    }
}


extension RoomListViewController {
    private func configureRoomListVC() {
        self.title = "단팅 그룹"
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubviews(self.roomListTableView, self.floatingButton)
        
        self.floatingButton.snp.makeConstraints {
            $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
            $0.bottom.equalTo(self.view.snp.bottom).offset(-35)
            $0.width.height.equalTo(55)
        }

        self.view.bringSubviewToFront(floatingButton)
    }
    
    private func generateViewsForRoomListPopupVC(room: Room) -> [UIView] {
        let meetingType = room.maxParticipants.integerToMeetingType()

        let heartImageView1 = UIImageView()
        let heartImageView2 = UIImageView()
        
        [heartImageView1, heartImageView2].forEach {
            $0.image = UIImage(systemName: "heart.fill")
            $0.tintColor = UIColor(hexCode: "#5A80FD")
            $0.contentMode = .scaleAspectFit
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        }

        let titleLabel = UILabel().then {
            $0.text = room.title
            $0.textAlignment = .left
            $0.textColor = .black
            $0.numberOfLines = 1
            $0.font = UIFont(name: "Pretendard-Bold", size: 18)
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        let descriptionLabel = UILabel().then {
            $0.text = room.subTitle
            $0.textAlignment = .left
            
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.font = UIFont(name: "Pretendard-Regular", size: 15)
        }
        
        lazy var firstStackView = UIStackView(arrangedSubviews: [heartImageView1, titleLabel]).then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.spacing = 11
        }

        
        lazy var secondStackView = UIStackView(arrangedSubviews: [heartImageView2, descriptionLabel]).then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .top
            $0.spacing = 11
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }

                
        lazy var thirdView = ParticipantsView()
        thirdView.participants = room.participants
        thirdView.meetingType = meetingType
        
        let heightValue = self.getHeightValueFromMeetingType(meetingType: meetingType)
        thirdView.heightAnchor.constraint(equalToConstant: heightValue).isActive = true
        let maxParticipants = room.maxParticipants
        let participants = room.participants
        let myGender = testUser.gender
        
       
        
        lazy var attendButton = UIButton().then {
            $0.setTitle("참가하기", for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor(hexCode: "#5A80FD")
            $0.setTitleColor(.white, for: .normal)
            $0.heightAnchor.constraint(equalToConstant: 55).isActive = true
            $0.addTarget(self, action: #selector(attendButtonDidTapped(_:)), for: .touchUpInside)
        }
        if maxParticipants/2 == participants.filter({$0.gender == myGender}).count  {
            attendButton.backgroundColor = UIColor(hexCode: "A8B1CE")
            attendButton.isEnabled = false
            attendButton.setTitle("가득참", for: .normal)
        }
        
        return [firstStackView, secondStackView, thirdView, attendButton]
        
    }
    
    private func getHeightValueFromMeetingType(meetingType: MeetingType) -> Double {
        switch meetingType {
        case .twoBytwo:
            return 44
        case .threeBythree:
            return 66
        case .fourByfour:
            return 88
        }
    }
    
    @objc func attendButtonDidTapped(_ sender: UIButton) {
        guard let room = self.myViewModel.room else { return }
        let maxParticipants = room.maxParticipants
//        let participants = room.participants
//        let myGender = testUser.gender
//        
//        guard maxParticipants/2 != participants.filter({$0.gender == myGender}).count  else {
//            sender.backgroundColor = UIColor(hexCode: "A8B1CE")
//            sender.isEnabled = false
//            return
//        }
        
        
        let meetingType = maxParticipants.integerToMeetingType()
        
        
        self.dismiss(animated: true)
    
        var standbyVC: UIViewController?
        
        switch meetingType {
        case .twoBytwo:
            let standbyVC2 = StandbyVC2()
            self.myViewModel.room?.participants.append(testUser)
            standbyVC2.myViewModel = self.myViewModel
            standbyVC = standbyVC2
        case .threeBythree:
            let standbyVC3 = StandbyVC3()
            self.myViewModel.room?.participants.append(testUser)
            standbyVC3.myViewModel = self.myViewModel
            standbyVC = standbyVC3
        case .fourByfour:
            let standbyVC4 = StandbyVC4()
            self.myViewModel.room?.participants.append(testUser)
            standbyVC4.myViewModel = self.myViewModel
            standbyVC = standbyVC4
        }
        
        self.navigationController?.pushViewController(standbyVC!, animated: true)
        
    }
    
    
}
