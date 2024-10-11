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
    
    private let participantsView = ParticipantsView()
    
    private lazy var attendButton = UIButton().then {
        $0.setTitle("참가하기", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(hexCode: "#5A80FD")
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(attendButtonDidTapped), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.participantsView.meetingType = .threeBythree
        self.configureAttendingVC()
        
     
    }
    
    
    
    @objc func attendButtonDidTapped() {
        print("Debug: opendKakaoChatting")
        
    }

}


extension AttendingViewController {
    private func configureAttendingVC() {
        
        self.view.backgroundColor = .clear
        
        self.view.addSubviews(self.popupView, self.logobaseView)
        
        self.popupView.addSubviews(self.heartImageView1, self.titleLabel,
                                   self.heartImageView2, self.descriptionLabel,
                                   self.participantsView, self.attendButton)
                
        self.logobaseView.addSubview(self.logoImageView)
        
        self.popupView.snp.makeConstraints {
            $0.width.equalTo(319)
            $0.height.equalTo(303)
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

        self.heartImageView1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(40)
            $0.height.equalTo(20)
            $0.width.equalTo(20)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.heartImageView1.snp.trailing).offset(10)
            $0.centerY.equalTo(self.heartImageView1.snp.centerY)
            $0.height.equalTo(22)
        }
        
        self.heartImageView2.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(self.heartImageView1.snp.bottom).offset(20)
            $0.height.equalTo(20)
            $0.width.equalTo(20)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.heartImageView2.snp.top)
            $0.leading.equalTo(self.heartImageView2.snp.trailing).offset(10)
            $0.width.equalTo(240)
            $0.height.equalTo(44)
        }
        
        self.attendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-21)
            $0.width.equalTo(273)
            $0.height.equalTo(45)
            
        }
        
        self.participantsView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().inset(35)
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(15)
            $0.bottom.equalTo(self.attendButton.snp.top).offset(-15)
        }
        
       
    }
}
