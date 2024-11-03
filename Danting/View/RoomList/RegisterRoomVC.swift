//
//  RegisterRoomVC.swift
//  Danting
//
//  Created by 김은상 on 10/25/24.
//

import UIKit
import SnapKit
import Then

final class RegisterRoomVC: UIViewController {
    //MARK: - Properties
    private let dantingLogoLabel = UILabel().then {
        $0.text = "DANTING"
        $0.font = UIFont(name: "Kodchasan-SemiBold", size: 32)
        $0.textColor = UIColor(hexCode: "5A80FD")
        $0.textAlignment = .center
    }
    
    private let roomTitleLabel = UILabel().then {
        $0.text = "방 제목"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }

    private let roomDescriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }

    private let roomTitleTextField = UITextField().then {
        $0.placeholder = "방 제목을 입력해주세요"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.clearButtonMode = .whileEditing // 편집 중에 지우기 버튼 표시
    }

    private let roomDescriptionView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
    }
    
    private let roomDescriptionTextView = UITextView().then {
        $0.text = "방 설명을 입력해주세요. 최대 100자"
        $0.textColor = .lightGray
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        
    }

    private let textCountLabel = UILabel().then {
        $0.textColor = UIColor(hexCode: "696E83")
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "0/100"
        
    }

    private let meetingTypeLabel = UILabel().then {
        $0.text = "인원 선택"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }

    private lazy var twoBytwoButton = UIButton().then {
        $0.setImage(UIImage(named: "twoBytwo"), for: .normal)
        $0.tag = 0
    }

    private lazy var threeBythreeButton = UIButton().then {
        $0.setImage(UIImage(named: "threeBythree"), for: .normal)
        $0.tag = 1
    }
    
    private lazy var fourByfourButton = UIButton().then {
        $0.setImage(UIImage(named: "fourBytfour"), for: .normal)
        $0.tag = 2
    }
    
    private let RegisterButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(hexCode: "5A80FD")
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
    }
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "방 만들기"
        self.view.backgroundColor = .white
        configureRegisterRoomVC()
        settingMeetingTypeButtons()


    }
    

    

}



extension RegisterRoomVC {
    private func configureRegisterRoomVC() {
        self.view.addSubviews(self.dantingLogoLabel, self.roomTitleLabel, self.roomDescriptionLabel,
                              self.roomTitleTextField,self.roomDescriptionView,self.roomDescriptionTextView,
                              self.textCountLabel, self.meetingTypeLabel, self.twoBytwoButton,
                              self.threeBythreeButton, self.fourByfourButton, self.RegisterButton)
        
        
        // 로고 위치 설정
        dantingLogoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // 방 제목 레이블 위치 설정
        roomTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dantingLogoLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 방 제목 텍스트 필드 위치 설정
        roomTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(roomTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        // 방 설명 레이블 위치 설정
        roomDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(roomTitleTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 방 설명 텍스트 뷰 위치 설정
        roomDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(roomDescriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        roomDescriptionTextView.snp.makeConstraints { make in
            make.edges.equalTo(roomDescriptionView).inset(10)
        }
        
        // 텍스트 카운트 레이블 위치 설정
        textCountLabel.snp.makeConstraints { make in
            make.top.equalTo(roomDescriptionView.snp.bottom).offset(8)
            make.trailing.equalTo(roomDescriptionView)
        }
        
        // 인원 선택 레이블 위치 설정
        meetingTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(textCountLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 인원 선택 버튼들 위치 설정
        twoBytwoButton.snp.makeConstraints { make in
            make.top.equalTo(meetingTypeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(55)
            make.width.equalTo(80)
        }
        
        threeBythreeButton.snp.makeConstraints { make in
            make.top.equalTo(twoBytwoButton)
            make.leading.equalTo(twoBytwoButton.snp.trailing).offset(20)
            make.height.equalTo(59)
            make.width.equalTo(110)
        }
        
        fourByfourButton.snp.makeConstraints { make in
            make.top.equalTo(twoBytwoButton)
            make.leading.equalTo(threeBythreeButton.snp.trailing).offset(20)
            make.height.equalTo(59)
            make.width.equalTo(140)
        }
        
        self.RegisterButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(680)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
    }
    
    private func settingMeetingTypeButtons() {
        
        /*[self.twoBytwoButton, self.threeBythreeButton, self.fourByfourButton].forEach {
         $0.backgroundColor = .clear
         $0.tintColor = UIColor(hexCode: "5A80FD")
         $0.imageView?.contentMode = .scaleAspectFit
         $0.layer.cornerRadius = 7
         $0.clipsToBounds = true
         $0.layer.borderColor = UIColor.black.cgColor
         $0.layer.borderWidth = 0.5
         }
         }*/
    }
}
