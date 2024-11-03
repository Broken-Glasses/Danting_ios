//
//  SplashViewControlloer.swift
//  Danting
//
//  Created by 임세윤 on 10/9/24.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo_wdanting1.png")
    }
    
    private let topLabel = UILabel().then {
        $0.text = "DANTING"
        $0.font = UIFont(name: "Kodchasan-SemiBold", size: 30)
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
    
    private var topConstraint: Constraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //배경
        self.activateBackgroundGradient()
        self.configureSplashVCUI()
        self.animateLogo()
        //로고 사진
//        self.view.addSubview(LogoImage)
//        LogoImage.snp.makeConstraints{ (make) in
//            make.centerX.equalTo(self.view)
//            make.top.equalTo(self.view).offset(343)
//        }
//        LogoImage.image = UIImage(named: "logo_wdanting1.png")
//
//       //로고 이름
//        self.view.addSubview(LogoName)
//        LogoName.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view)
//            make.top.equalTo(self.view).offset(430)
//        }
//        
//        LogoName.image = UIImage(named: "logo_wdanting2.png")
//        
//        
//        //하단 로고
//        self.view.addSubview(BottomLogo1)
//        
//        BottomLogo1.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(752)
//            make.centerX.equalTo(self.view)
//        }
//        
//        BottomLogo1.image = UIImage(named: "logo_with.png")
//        
//        self.view.addSubview(BottomLogo2)
//        
//        BottomLogo2.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view)
//            make.top.equalTo(self.view).offset(782)
//        }
//        
//        BottomLogo2.image = UIImage(named: "logo_dankook.png")
      
        
    }
    
    func configureSplashVCUI() {
        self.view.addSubviews(self.logoImageView, self.topLabel, self.bottomLabel)
        
        self.logoImageView.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view).offset(343) //235
            self.topConstraint = make.top.equalTo(self.view).offset(343).constraint
        }
        
        self.topLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(3)
        }
        
        
        self.bottomLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(752)
            $0.centerX.equalToSuperview()
            
        }

    }
  
}

extension SplashViewController {
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
    
    
    private func animateLogo() {
        // 2초 동안 top 제약 조건을 343에서 235로 변경하는 애니메이션
        DispatchQueue.main.asyncAfter(deadline: .now()) { // 약간의 딜레이를 줄 수도 있음
            self.topConstraint.update(offset: 235) // top 제약 조건 변경
            
            UIView.animate(withDuration: 1.5, animations: {
                self.view.layoutIfNeeded() // 레이아웃 업데이트를 애니메이션화
            })
        }
    }
    
}
