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
    //MARK: - Properties
    private lazy var firstUserStackView = UIStackView(arrangedSubviews: [firstUserImageButton, firstUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var firstUserImageButton = UIButton().then { $0.setImage(UIImage(named: "unready.png"), for: .normal) }
    
    private lazy var firstUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var secondUserStackView = UIStackView(arrangedSubviews: [secondUserImageButton, secondUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var secondUserImageButton = UIButton().then { $0.setImage(UIImage(named: "unready.png"), for: .normal) }
    
    private lazy var secondUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var thirdUserStackView = UIStackView(arrangedSubviews: [thirdUserImageButton, thirdUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var thirdUserImageButton = UIButton().then { $0.setImage(UIImage(named: "unready.png"), for: .normal) }
    
    private lazy var thirdUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var fourthUserStackView = UIStackView(arrangedSubviews: [fourthUserImageButton, fourthUserNameLabel]).then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
        
    }
    
    private lazy var fourthUserImageButton = UIButton().then { $0.setImage(UIImage(named: "unready.png"), for: .normal) }
    
    private lazy var fourthUserNameLabel = UILabel().then {
        $0.text = "김단국"
        $0.textAlignment = .center
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStandyVC2()
        
    }
    

    

}


extension StandbyVC2 {
    private func configureStandyVC2() {
        self.view.addSubviews(firstUserStackView, secondUserStackView,
                              thirdUserStackView, fourthUserStackView)
        
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
        
        
    }
}
