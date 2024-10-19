//
//  ParticipantsView.swift
//  Danting
//
//  Created by 김은상 on 10/10/24.
//

import UIKit
import SnapKit
import Then

final class ParticipantsView: UIView {
    
    private let man1Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        $0.font = UIFont(name: "Pretendard-Regular", size: 11)
        
    }
    
    private let man2Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        
        
    }
    
    private let man3Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        
        
    }
    
    private let man4Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        
        
    }
    
    private let girl1Label = UILabel().then {
        $0.text = "24 | 커뮤니케이션디자인전공"
        
        
    }
    
    private let girl2Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        
        
    }
    
    private let girl3Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        
        
    }
    
    private let girl4Label = UILabel().then {
        $0.text = "24 | 기계공학과"
        
        
    }
    
    private let heartImageView = UIImageView().then {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = UIColor(hexCode: "#5A80FD")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var manLabels = [self.man1Label, self.man2Label,
                                  self.man3Label, self.man4Label]
    
    private lazy var girlLabels = [self.girl1Label, self.girl2Label,
                                  self.girl3Label, self.girl4Label]
    
    var meetingType: MeetingType? {
        didSet {
            guard let meetingType = self.meetingType else { return }
            self.configureUIWithType(meetingType: meetingType)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.settingLabelFontAndTextAttributes()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    
}

extension ParticipantsView {
    private func configureUIWithType(meetingType: MeetingType) {
        
        
        switch meetingType {
        case .twoBytwo:
            self.configure2by2()
        case .threeBythree:
            self.configure3by3()
        case .fourByfour:
            self.configure4by4()
        }
    }
    
    
    private func configure2by2() {
        self.addSubviews(self.man1Label, self.man2Label,
                         self.girl1Label, self.girl2Label,
                         self.heartImageView)
        
        self.man1Label.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        self.man2Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(man1Label.snp.bottom)
            $0.height.equalTo(22)
        }
        
        self.girl1Label.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        self.girl2Label.snp.makeConstraints {
            $0.top.equalTo(girl1Label.snp.bottom)
            $0.trailing.equalTo(girl1Label)
            $0.height.equalTo(22)
        }
        
        self.heartImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(18)
            $0.height.equalTo(18)
            $0.top.equalTo(man1Label.snp.bottom).offset(-11)
        }
    }
    
    private func configure3by3() {
        self.addSubviews(self.man1Label, self.man2Label, self.man3Label,
                         self.girl1Label, self.girl2Label, self.girl3Label,
                         self.heartImageView)
        
        
        self.man2Label.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        self.man1Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(self.man2Label.snp.top)
            $0.height.equalTo(22)
        }
        
        self.man3Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(self.man2Label.snp.bottom)
            $0.height.equalTo(22)
        }
        
        self.girl2Label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        self.girl1Label.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.man2Label.snp.top)
            $0.height.equalTo(22)
        }
        
        self.girl3Label.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.man2Label.snp.bottom)
            $0.height.equalTo(22)
        }
        
        self.heartImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        
    }
    
    private func configure4by4() {
        self.addSubviews(self.man1Label, self.man2Label,
                         self.man3Label, self.man4Label,
                         self.girl1Label, self.girl2Label,
                         self.girl3Label, self.girl4Label,
                         self.heartImageView)
        self.heartImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        
        self.man2Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(self.heartImageView.snp.top).offset(+11)
            $0.height.equalTo(22)
        }
        
        self.man3Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(self.heartImageView.snp.bottom).offset(-11)
            $0.height.equalTo(22)
        }
        
        self.man1Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalTo(self.man2Label.snp.top)
            $0.height.equalTo(22)
        }
        
        self.man4Label.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(self.man3Label.snp.bottom)
            $0.height.equalTo(22)
        }
        
        
        self.girl2Label.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.heartImageView.snp.top).offset(+11)
            $0.height.equalTo(22)
        }
        
        self.girl3Label.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.heartImageView.snp.bottom).offset(-11)
            $0.height.equalTo(22)
        }
        
        self.girl1Label.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.girl2Label.snp.top)
            $0.height.equalTo(22)
        }
        
        self.girl4Label.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.girl3Label.snp.bottom)
            $0.height.equalTo(22)
        }
        
        
        
        
    }
    
    private func settingLabelFontAndTextAttributes() {
        self.manLabels.forEach { $0.font = UIFont(name: "Pretendard-Regular", size: 11)}
        self.girlLabels.forEach { $0.font = UIFont(name: "Pretendard-Regular", size: 11)}
    }
}



