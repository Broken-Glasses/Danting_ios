//
//  StandbyViewController.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

import UIKit
import SnapKit
import Then

protocol RequestForOpenKakao {
    func requestReadyState(roomId: Int)
    func repeatRequest()
}

protocol StandbyInformation {
    func presentInfoView(tag: Int)
}

class StandbyViewController: UIViewController {

    private lazy var readyButton = UIButton().then {
        $0.setTitle("준비", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "#FFFFFF"), for: .normal)
        
        $0.backgroundColor = UIColor(hexCode: "#5A80FD")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(readyButtonDidTapped(_:)), for: .touchUpInside)
    }
    
    private let findingLoveLabel = UILabel().then {
        $0.text = "Finding Love"
        $0.textColor = UIColor(hexCode: "#5A80FD")
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    private let readyLabel = UILabel().then {
        $0.text = "준비를 완료해주세요"
        $0.textColor = UIColor(hexCode: "#404040")
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let heartImage = UIImageView().then {
        $0.image = UIImage(named: "heart_with_text")?.withRenderingMode(.alwaysTemplate)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(hexCode: "#D7D7D7")
    }
    
    private let backgroundCircle = UIImageView().then {
        $0.image = UIImage(named: "backgroundCircle")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var dot_1 = createDot(at: CGPoint(x: 140, y: 159), size: 21, colorHex: "CEDEFF", alpha: 0.35)
    private lazy var dot_2 = createDot(at: CGPoint(x: 211, y: 195), size: 11, colorHex: "CEDEFF", alpha: 0.75)
    private lazy var dot_3 = createDot(at: CGPoint(x: 337, y: 209), size: 11, colorHex: "CEDEFF", alpha: 0.35)
    private lazy var dot_4 = createDot(at: CGPoint(x: 42, y: 227), size: 9, colorHex: "CEDEFF", alpha: 0.35)
    private lazy var dot_5 = createDot(at: CGPoint(x: 38, y: 243), size: 19, colorHex: "CEDEFF", alpha: 0.75)
    private lazy var dot_6 = createDot(at: CGPoint(x: 339, y: 252), size: 21, colorHex: "CEDEFF", alpha: 0.75)
    private lazy var dot_7 = createDot(at: CGPoint(x: 356, y: 302), size: 9, colorHex: "CEDEFF", alpha: 0.75)
    private lazy var dot_8 = createDot(at: CGPoint(x: 371, y: 311), size: 5, colorHex: "CEDEFF", alpha: 0.35)
    private lazy var dot_9 = createDot(at: CGPoint(x: 16, y: 315), size: 6, colorHex: "CEDEFF", alpha: 1.0)
    private lazy var dot_10 = createDot(at: CGPoint(x: 30, y: 484), size: 13, colorHex: "CEDEFF", alpha: 0.35)
    private lazy var dot_11 = createDot(at: CGPoint(x: 365, y: 491), size: 7, colorHex: "CEDEFF", alpha: 0.35)
    private lazy var dot_12 = createDot(at: CGPoint(x: 66, y: 176), size: 7, colorHex: "CEDEFF", alpha: 1.0)
    private lazy var dot_13 = createDot(at: CGPoint(x: 311, y: 526), size: 13, colorHex: "CEDEFF", alpha: 0.37)
    private lazy var dot_14 = createDot(at: CGPoint(x: 348, y: 525), size: 5, colorHex: "CEDEFF", alpha: 1.0)
    private lazy var dot_15 = createDot(at: CGPoint(x: 157, y: 577), size: 13, colorHex: "CEDEFF", alpha: 0.75)
    private lazy var dot_16 = createDot(at: CGPoint(x: 223, y: 602), size: 7, colorHex: "CEDEFF", alpha: 0.35)

    private var currentDotCount = 0
    
    private let dotSequence = [0, 1, 2, 3, 2, 1, 0] // 점의 수 배열
        
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCommonComponents()
        self.animateTintColorChange()
        self.animateDotsFading()
        self.animateDots()
    }
    
    
    private func fetchReadyState() {
        // 전부 준비 완료라면 카카오톡 오픈 채팅방으로 들어가는 부분
        let popupVC = PopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        let views = self.generateViewsForOpenKakao()
        popupVC.addSubviewsToStackView(views: views, spacing: 20, bottomSpacing: 10, topSpacing: 20) {
            self.present(popupVC, animated: true, completion: nil)
        }
        
        
    }

    func configureButtonState(sender: UIButton, isReady: Bool) {
        if isReady {
            sender.backgroundColor = UIColor(hexCode: "#A8B1CE")
            sender.setTitle("취소", for: .normal)
        } else {
            sender.backgroundColor = UIColor(hexCode: "#5A80FD")
            sender.setTitle("준비", for: .normal)
            
        }
    }
    
    //MARK: - Action
    @objc func readyButtonDidTapped(_ sender: UIButton) { }
    
    @objc func openKakaoChatting() {
        print("Debug: Open Kakao Open Chatting")
    }
}


extension StandbyViewController {
    private func createDot(at position: CGPoint, size: CGFloat, colorHex: String, alpha: CGFloat) -> UIView {
        let dot = UIView(frame: CGRect(x: position.x, y: position.y, width: size, height: size))
        dot.backgroundColor = UIColor(hexCode: colorHex).withAlphaComponent(alpha)
        dot.layer.cornerRadius = size / 2
        dot.clipsToBounds = true
        return dot
    }
    
    private func configureCommonComponents() {
        
        self.navigationController?.title = "대기"
        
        self.view.backgroundColor = UIColor(hexCode: "#FFFFFF")
        
        self.backgroundCircle.addSubview(self.heartImage)
        
        self.view.addSubviews(self.readyButton, self.readyLabel, self.findingLoveLabel,
                              self.backgroundCircle)
        self.view.addSubviews(dot_1, dot_2, dot_3, dot_4,
                              dot_5, dot_6, dot_7, dot_8,
                              dot_9, dot_10, dot_11, dot_12,
                              dot_13, dot_14, dot_15, dot_16)
        self.findingLoveLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(22)
            $0.bottom.equalToSuperview ().offset(-195)
        }
        
        self.readyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.findingLoveLabel.snp.bottom).offset(9)
            $0.width.equalTo(97)
            $0.height.equalTo(22)
        }
        
        self.readyButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.readyLabel.snp.bottom).offset(51)
            $0.width.equalTo(361)
            $0.height.equalTo(55)

        }
        
        self.backgroundCircle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.findingLoveLabel.snp.top).offset(-88)
            $0.width.height.equalTo(358)
        }
        
        self.heartImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    
    private func animateTintColorChange() {
        UIView.animate(withDuration: 3.0, animations: {
            self.heartImage.tintColor = UIColor(hexCode: "#FB6969")
        }, completion: { _ in
            UIView.animate(withDuration: 3.0, animations: {
                self.heartImage.tintColor = UIColor(hexCode: "#D7D7D7")
            }, completion: { _ in
                self.animateTintColorChange()
            })
        })
    }
    
    private func animateDotsFading() {
        let dots = [dot_1, dot_2, dot_3, dot_4, dot_5, dot_6, dot_7, dot_8, dot_9, dot_10,
                    dot_11, dot_12, dot_13, dot_14, dot_15, dot_16]

        let group = DispatchGroup()

        for dot in dots {
            group.enter()

            let originalAlpha = dot.alpha

            UIView.animate(withDuration: 3.0, animations: {
                dot.alpha = 0
            }) { _ in
                UIView.animate(withDuration: 3.0, animations: {
                    dot.alpha = originalAlpha
                }) { _ in
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.animateDotsFading()
        }
    }
    private func animateDots() {
        findingLoveLabel.text = "Finding Love"
        currentDotCount = 0
        
        for (index, count) in dotSequence.enumerated() {
            let delay = Double(index) * 0.5 // 0.5초 간격으로 애니메이션 수행
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.updateLabelWithDots(count: count)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(dotSequence.count)) { // 전체 애니메이션 시간
            self.animateDots()
        }
    }
    
    private func updateLabelWithDots(count: Int) {
        let dots = String(repeating: "·", count: count)
        self.findingLoveLabel.text = "Finding Love" + dots
    }
    
    func generateViewsForOpenKakao() -> [UIView] {
        let titleLabel = UILabel().then {
            $0.text = "새로운 만남을 가질 준비가 되었나요?"
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        }
        
        let descriptionLabel = UILabel().then {
            $0.text = "상호 간의 배려를 통해 즐거운 만남을 이어가 보세요.\n타인에 대한 비방이나 욕설은 처벌의 대상이 됩니다."
            $0.textAlignment = .center
            $0.textColor = .black
            $0.numberOfLines = 2
            $0.font = UIFont(name: "Pretendard-Light", size: 13)
        }
        
        lazy var kakaoChatButton = UIButton().then {
            $0.setTitle("카카오로 3초만에 시작하기", for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor(hexCode: "#FBE400")
            $0.setTitleColor(UIColor(hexCode: "#3E1A1D"), for: .normal)
            $0.semanticContentAttribute = .forceLeftToRight
            $0.contentHorizontalAlignment = .fill
            $0.contentVerticalAlignment = .center
            $0.setImage(UIImage(named: "logo_kakao.png"), for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 23, bottom: 2, right: 2)
            $0.titleEdgeInsets = UIEdgeInsets(top: 2, left: 40, bottom: 2, right: 2)
            $0.heightAnchor.constraint(equalToConstant: 45).isActive = true
            $0.addTarget(self, action: #selector(openKakaoChatting), for: .touchUpInside)
        }
        
        
        
        return [titleLabel, descriptionLabel, kakaoChatButton]
    }
}
