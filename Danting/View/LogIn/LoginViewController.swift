//
//  ViewController.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo_wdanting1.png")
    }
    
    private let topLabel = UILabel().then {
        $0.text = "DANTING"
        $0.font = UIFont(name: "Kodchasan-SemiBold", size: 30)
        $0.textColor = .white
        $0.textAlignment = .center
    }

    private let logInLabel = UILabel().then {
        $0.text = "LOG - IN"
        $0.font = UIFont(name: "Kodchasan-Regular", size: 15)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let bottomLabel = UILabel().then {
        $0.text = "with \n DANKOOK UNIV."
        $0.font = UIFont(name: "Kodchasan-Regular", size: 15)
        $0.textColor = .white
        $0.numberOfLines = 3
        $0.textAlignment = .center
    }
    
    private lazy var nickNameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요."
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.delegate = self
        $0.clearButtonMode = .whileEditing // 편집 중에 지우기 버튼 표시
    }
    
    private let nickNameConfirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(hexCode: "5A80FD")
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activateBackgroundGradient()
        self.configureLoginVC()
    }
    
   
}
extension LoginViewController: UITextFieldDelegate {
    //텍스트 필드 관련 메서드는 여기에
    
    
}



extension LoginViewController {
    private func activateBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let topColor = UIColor(hexCode: "#5A80FD").cgColor
        let bottomColor = UIColor(hexCode: "CEDEFF").cgColor
        let colors: [CGColor] = [topColor, bottomColor]
        
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        
        self.view.layer.addSublayer(gradientLayer)

    }
    
    
    
    private func configureLoginVC() {
        self.view.addSubviews(
                              self.logoImageView, self.topLabel,
                              self.logInLabel,
                              self.bottomLabel,
                              self.nickNameTextField,
                              self.nickNameConfirmButton)
        
        self.logoImageView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view).offset(235)
        }
        
        self.topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(3)
        }
        
        self.logInLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(521)
        }
        
        
        self.nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(self.logInLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
        
        self.nickNameConfirmButton.snp.makeConstraints {
            $0.top.equalTo(self.nickNameTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
        
        self.bottomLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(752)
            $0.centerX.equalToSuperview()

        }
      
        

    }
}
