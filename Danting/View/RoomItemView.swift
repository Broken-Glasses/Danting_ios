//
//  RoomItemView.swift
//  Danting
//
//  Created by DonghyeonKim on 10/10/24.
//

import UIKit
import Then

final class RoomItemCell: UITableViewCell {
    //MARK: - Properties
    
    let roomItemView = RoomItemView()
    
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //MARK: - Helpers
    private func setupCell() {
        self.contentView.addSubview(self.roomItemView)
        self.roomItemView.translatesAutoresizingMaskIntoConstraints = false
        
        // customItemView 레이아웃 설정
        NSLayoutConstraint.activate([
            roomItemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            roomItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            roomItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            roomItemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

final class RoomItemView: UIView {
    //MARK: - Properties
    let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemBlue.cgColor
        $0.layer.cornerRadius = 12
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowRadius = 8
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "room_logo.svg") // 아이콘 이미지 설정
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let titleLabel = UILabel().then {
        $0.text = "술 배틀 뛸 사람 들어와"
        $0.font = UIFont(name: "Pretendard-Bold", size: 15)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let subtitleLabel = UILabel().then {
        $0.text = "공대에서 술 잘 마시는 여성분들 구합니다. 여성분들 자신있으면 아무나..."
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = UIColor(hexCode: "B4C2DC")
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let blueHeartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .systemBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let redHeartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .systemRed
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let blueHeartLabel = UILabel().then {
        $0.text = "3/3 명"
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = UIColor(hexCode: "A8B1CE")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let redHeartLabel = UILabel().then {
        $0.text = "1/3 명"
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = UIColor(hexCode: "A8B1CE")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var blueHeartButtonStackView = UIStackView(arrangedSubviews: [blueHeartButton, blueHeartLabel]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private lazy var redHeartButtonStackView = UIStackView(arrangedSubviews: [redHeartButton, redHeartLabel]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var labelStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    //MARK: - Helpers
    private func setupView() {
        self.addSubview(self.containerView)
        self.containerView.addSubviews(self.iconImageView,
                                       self.labelStackView,
                                       self.redHeartButtonStackView,
                                       self.blueHeartButtonStackView)
        

        // containerView의 크기를 명시적으로 설정
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        labelStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.trailing.lessThanOrEqualTo(redHeartButtonStackView.snp.leading).offset(-16)
        }
        
        blueHeartButtonStackView.snp.makeConstraints { (make) in
            make.top.equalTo(labelStackView.snp.top)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        
        redHeartButtonStackView.snp.makeConstraints { (make) in
            make.top.equalTo(blueHeartButtonStackView.snp.bottom).offset(5)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
}
