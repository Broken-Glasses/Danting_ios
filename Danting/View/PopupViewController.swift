//
//  PopupViewController.swift
//  Danting
//
//  Created by 김은상 on 10/6/24.
//

import UIKit
import Then
import SnapKit

class PopupViewController: UIViewController {
    //MARK: - Properties
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "#B6B6B6").withAlphaComponent(0.49)
        $0.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
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
    
    private let titleLabel = UILabel().then {
        $0.text = "새로운 만남을 가질 준비가 되었나요?"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "상호 간의 배려를 통해 즐거운 만남을 이어가 보세요. 타인에 대한 비방이나 욕설은 처벌의 대상이 됩니다."
        $0.textAlignment = .left
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Pretendard-Light", size: 12)
    }
    
    private lazy var kakaoChatButton = UIButton().then {
        $0.setTitle("카카오로 3초만에 시작하기", for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(hexCode: "#FBE400")
        $0.setTitleColor(UIColor(hexCode: "#3E1A1D"), for: .normal)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .center
        $0.setImage(UIImage(named: "logo_kakao.png"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 23, bottom: 2, right: 2)
        $0.titleEdgeInsets = UIEdgeInsets(top: 2, left: 40, bottom: 2, right: 2)
        $0.addTarget(self, action: #selector(openKakaoChatting), for: .touchUpInside)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePopupVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // curveEaseOut: 시작은 천천히, 끝날 땐 빠르게
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.backgroundView.transform = .identity
            self?.backgroundView.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.backgroundView.transform = .identity
            self?.backgroundView.isHidden = true
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Helpers
    
    
    @objc func openKakaoChatting() {
        print("Debug: opendKakaoChatting")
        
    }
    
    
}

extension PopupViewController {
    private func configurePopupVC() {
        
        self.view.backgroundColor = .clear
        self.view.addSubview(self.backgroundView)
        
        self.backgroundView.addSubviews(self.popupView, self.logobaseView,
                                        self.titleLabel, self.descriptionLabel,
                                        self.kakaoChatButton)
                
        self.logobaseView.addSubview(self.logoImageView)
        
        self.backgroundView.snp.makeConstraints { $0.edges.equalToSuperview()}
        
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
        
        self.kakaoChatButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.width.equalTo(273)
            $0.height.equalTo(45)
            
        }
    }
    
}
