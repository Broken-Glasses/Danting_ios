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
        $0.backgroundColor = .white
    }

    private let roomDescriptionView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.layer.borderColor = (UIColor(hexCode: "5A80FD") ?? .systemBlue).cgColor
        $0.layer.borderWidth = 1
    }
    
    private let roomDescriptionTextView = UITextView().then {
        $0.backgroundColor = .clear
        
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
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    

}



extension RegisterRoomVC {
    private func configureRegisterRoomVC() {
        self.view.addSubviews(self.dantingLogoLabel, self.roomTitleLabel, self.roomDescriptionLabel,
                              self.roomTitleTextField)
    }
    
    private func settingMeetingTypeButtons() {
        
        [self.twoBytwoButton, self.threeBythreeButton, self.fourByfourButton].forEach {
            $0.backgroundColor = .clear
            $0.tintColor = UIColor(hexCode: "5A80FD")
            $0.imageView?.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 7
            $0.clipsToBounds = true
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 0.5
        }
    }
}
