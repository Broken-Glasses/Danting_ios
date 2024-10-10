//
//  RoomItemView.swift
//  Danting
//
//  Created by DonghyeonKim on 10/10/24.
//

import UIKit

class RoomItemCell: UITableViewCell {
    
    let roomItemView = RoomItemView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(roomItemView)
        roomItemView.translatesAutoresizingMaskIntoConstraints = false
        
        // customItemView 레이아웃 설정
        NSLayoutConstraint.activate([
            roomItemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            roomItemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            roomItemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            roomItemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

class RoomItemView: UIView {

    let containerView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let blueHeartButton = UIButton()
    let redHeartButton = UIButton()
    let blueHeartLabel = UILabel()
    let redHeartLabel = UILabel()

    let blueHeartButtonStackView = UIStackView()
    let redHeartButtonStackView = UIStackView()
    let labelStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

    func setupView() {
        // 컨테이너 뷰 설정
        containerView.backgroundColor = .white
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemBlue.cgColor
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)

        // 아이콘 이미지 설정
        iconImageView.image = UIImage(named: "room_logo.svg") // 아이콘 이미지 설정
        iconImageView.layer.cornerRadius = 8
        iconImageView.clipsToBounds = true
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        // 제목 레이블 설정
        titleLabel.text = "술 배틀 뛸 사람 들어와"
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // 부제목 레이블 설정
        subtitleLabel.text = "공대에서 술 잘 마시는 여성분들 구합니다. 여성분들 자신있으면 아무나..."
        subtitleLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        subtitleLabel.textColor = UIColor(hexCode: "B4C2DC")
        subtitleLabel.numberOfLines = 2
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        // 파란색 하트 버튼 설정
        blueHeartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        blueHeartButton.tintColor = .systemBlue
        blueHeartButton.translatesAutoresizingMaskIntoConstraints = false

        // 빨간색 하트 버튼 설정
        redHeartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        redHeartButton.tintColor = .systemRed
        redHeartButton.translatesAutoresizingMaskIntoConstraints = false

        // 하트 버튼에 붙일 라벨 설정
        blueHeartLabel.text = "3/3 명"
        blueHeartLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        blueHeartLabel.textColor = UIColor(hexCode: "A8B1CE")
        blueHeartLabel.translatesAutoresizingMaskIntoConstraints = false

        redHeartLabel.text = "1/3 명"
        redHeartLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        redHeartLabel.textColor = UIColor(hexCode: "A8B1CE")
        redHeartLabel.translatesAutoresizingMaskIntoConstraints = false

        // StackViews 설정
        setupStackViews()

        // 오토레이아웃 설정
        setupConstraints()
    }

    func setupStackViews() {
        // 레이블 스택뷰 (제목 + 부제목)
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.spacing = 4
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subtitleLabel)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false

        // 하트 버튼 스택뷰 (파란 하트 + 빨간 하트)
        redHeartButtonStackView.axis = .horizontal
        redHeartButtonStackView.alignment = .center
        redHeartButtonStackView.spacing = 8
        redHeartButtonStackView.addArrangedSubview(redHeartButton)
        redHeartButtonStackView.addArrangedSubview(redHeartLabel)
        redHeartButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        blueHeartButtonStackView.axis = .horizontal
        blueHeartButtonStackView.alignment = .center
        blueHeartButtonStackView.spacing = 8
        blueHeartButtonStackView.addArrangedSubview(blueHeartButton)
        blueHeartButtonStackView.addArrangedSubview(blueHeartLabel)
        blueHeartButtonStackView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(iconImageView)
        containerView.addSubview(labelStackView)
        containerView.addSubview(redHeartButtonStackView)
        containerView.addSubview(blueHeartButtonStackView)
    }

    func setupConstraints() {
        // containerView의 크기를 명시적으로 설정
        containerView.snp.makeConstraints { (make) in
//            make.left.equalTo(self.snp.left).offset(20)
//            make.right.equalTo(self.snp.right).offset(20)
//            make.top.equalTo(self.snp.top).offset(10)
//            make.bottom.equalTo(self.snp.bottom).offset(10)
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
