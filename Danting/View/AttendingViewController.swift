//
//  AttendingViewController.swift
//  Danting
//
//  Created by 김은상 on 10/10/24.
//

import UIKit
import SnapKit
import Then

final class AttendingViewController: PopupViewController {
    
    private let popupView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
    }
    
    private let logobaseView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 29
        $0.backgroundColor = .white
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo_danting.png")
        $0.contentMode = .scaleAspectFill
    }
    
    
    private let heartImageView1 = UIImageView().then {
        $0.image = UIImage(systemName: "heart.fill")
        $0.tintColor = UIColor(hexCode: "#5A80FD")
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "새로운 만남을 가질 준비가 되었나요?"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private let heartImageView2 = UIImageView().then {
        $0.image = UIImage(systemName: "heart.fill")
        $0.tintColor = UIColor(hexCode: "#5A80FD")
        $0.clipsToBounds = true
    }
    
    
    private let descriptionLabel = UILabel().then {
        $0.text = "상호 간의 배려를 통해 즐거운 만남을 이어가 보세요. 타인에 대한 비방이나 욕설은 처벌의 대상이 됩니다."
        $0.textAlignment = .left
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Pretendard-Light", size: 12)
    }
    
    private lazy var attendButton = UIButton().then {
        $0.setTitle("참가하기", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(hexCode: "#FBE400")
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(attendButtonDidTapped), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAttendingVC()
     
    }
    
    
    
    @objc func attendButtonDidTapped() {
        print("Debug: opendKakaoChatting")
        
    }

}


extension AttendingViewController {
    private func configureAttendingVC() {
        
        self.view.backgroundColor = .clear
        
        self.view.addSubviews(self.popupView, self.logobaseView,
                              self.titleLabel, self.descriptionLabel,
                              self.attendButton)
                
        self.logobaseView.addSubview(self.logoImageView)
        
        self.popupView.snp.makeConstraints {
            $0.width.equalTo(319)
            $0.height.equalTo(216)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(300)
        }
        
        self.logobaseView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(271)
            $0.width.height.equalTo(63)
        }
        
        self.logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(63)
        }

        
        
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(popupView.snp.top).offset(61)
            $0.width.equalTo(260)
            $0.height.equalTo(19)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.equalTo(260)
            $0.height.equalTo(40)
        }
        
        self.attendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.width.equalTo(273)
            $0.height.equalTo(45)
            
        }
    }
}
