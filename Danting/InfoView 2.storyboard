//
//  InfoView.swift
//  Danting
//
//  Created by 김은상 on 10/7/24.
//

import UIKit
import SnapKit
import Then

final class InfoView: UIView {

    var studentNum: Int?
    var major: String?
    
    private lazy var studentNumLabel = UILabel().then {
        $0.text = "32240000"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textAlignment = .center
    }
    
    private lazy var majorLabel = UILabel().then {
        $0.text = "어쩌구저쩌구학부"
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textAlignment = .center
    }
    
    private lazy var nameMajorStackView = UIStackView(arrangedSubviews: [studentNumLabel, majorLabel]).then {
        $0.axis = .vertical
        $0.spacing = 7
        $0.distribution = .fillEqually
    }
    
    private let emptyView = UIView()
    
    private lazy var infoStackView = UIStackView(arrangedSubviews: [emptyView, nameMajorStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
    }
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureInfoView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
}


extension InfoView {
    private func configureInfoView() {
        self.backgroundColor = UIColor(hexCode: "#5A80FD")

        self.addSubviews(self.infoStackView)
        
        self.infoStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(13)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(33)
            
        }
        
    }
}
