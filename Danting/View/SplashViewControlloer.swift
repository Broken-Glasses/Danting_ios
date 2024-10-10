//
//  SplashViewControlloer.swift
//  Danting
//
//  Created by 임세윤 on 10/9/24.
//

import UIKit
import SnapKit

class SplashViewControlloer: UIViewController {
    var LogoImage = UIImageView()
    var LogoName = UIImageView()
    var BottomLogo1 = UIImageView()
    var BottomLogo2 = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //배경
        activateBackgroundGradient()
        
        //로고 사진
        self.view.addSubview(LogoImage)
        LogoImage.snp.makeConstraints{ (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(343)
        }
        LogoImage.image = UIImage(named: "logo_wdanting1.png")

       //로고 이름
        self.view.addSubview(LogoName)
        LogoName.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(430)
                    
                }
        LogoName.image = UIImage(named: "logo_wdanting2.png")
        
        
        //하단 로고
        self.view.addSubview(BottomLogo1)
        BottomLogo1.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(752)
            make.centerX.equalTo(self.view)
                }
        BottomLogo1.image = UIImage(named: "logo_with.png")
        
        self.view.addSubview(BottomLogo2)
        BottomLogo2.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(782)
                }
        BottomLogo2.image = UIImage(named: "logo_dankook.png")
        
    }
    
    
    
}

extension SplashViewControlloer {
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
}
