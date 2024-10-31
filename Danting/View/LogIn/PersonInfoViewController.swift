//
//  PersonInfoViewController.swift
//  Danting
//
//  Created by 임세윤 on 10/30/24.
//

import UIKit
import SnapKit

final class PersonInfoViewController: UIViewController {
    
    private let dantingLogoLabel = UILabel().then {
        $0.text = "DANTING"
        $0.font = UIFont(name: "Kodchasan-SemiBold", size: 32)
        $0.textColor = UIColor(hexCode: "5A80FD")
        $0.textAlignment = .center
    }
    
    private let personIDLabel = UILabel().then {
        $0.text = "학번"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    private let personMajorLabel = UILabel().then {
        $0.text = "학과"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    private let personIDField = UITextField().then {
        $0.placeholder = "학번을 입력해주세요. ex)32190111"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = .white
            self.configurePersonInfoUI()
            
            
        }
}

extension PersonInfoViewController {
    private func configurePersonInfoUI() {
        self.title = "기본정보"
        self.view.addSubviews(self.dantingLogoLabel, self.personIDLabel, self.personMajorLabel,                                self.personIDField)
            
        
        
        self.dantingLogoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 수평 중앙 정렬
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20) // 상단에서 20pt 아래
        }
        
        // 학번 레이블 위치 설정
        personIDLabel.snp.makeConstraints { make in
            make.top.equalTo(dantingLogoLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 학과 레이블 위치 설정
        personMajorLabel.snp.makeConstraints { make in
            make.top.equalTo(personIDField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 학번 텍스트 필드 위치 설정
        personIDField.snp.makeConstraints { make in
            make.top.equalTo(personIDLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
}
