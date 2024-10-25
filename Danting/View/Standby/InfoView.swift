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
    
    private lazy var studentNumLabel = UILabel().then {
        $0.text = "로딩중..."
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textAlignment = .center
    }
    
    private lazy var majorLabel = UILabel().then {
        $0.text = "로딩중..."
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textAlignment = .center
    }
    
    private lazy var nameMajorStackView = UIStackView(arrangedSubviews: [studentNumLabel, majorLabel]).then {
        $0.axis = .vertical
        $0.spacing = 7
        $0.distribution = .fillEqually
    }
    
    private let leftEmptyView = UIView()
    private let rightEmptyView = UIView()
    
    private lazy var infoStackView = UIStackView(arrangedSubviews: [leftEmptyView, nameMajorStackView, rightEmptyView]).then {
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
}


extension InfoView {
    private func configureInfoView() {
        self.backgroundColor = UIColor(hexCode: "#5A80FD")

        self.addSubviews(self.infoStackView)
        
        self.infoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(33)
            
        }
        
        self.leftEmptyView.snp.makeConstraints {$0.width.equalTo(13)}
        self.rightEmptyView.snp.makeConstraints { $0.width.equalTo(13)}
    }
    
    func updateWithData(studentID: String, major: String) {
        self.majorLabel.text = major
        self.studentNumLabel.text = studentID
        
    }
}
