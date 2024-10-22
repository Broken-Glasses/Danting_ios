//
//  PopupViewController.swift
//  Danting
//
//  Created by 김은상 on 10/6/24.
//

import UIKit
import Then
import SnapKit

enum PopUpType {
    case OpenKakao
    case AttendingRoom
}

class PopupViewController: UIViewController {
    //MARK: - Properties
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(hexCode: "#B6B6B6").withAlphaComponent(0.49)
        $0.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    private lazy var popupView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30

    }
    
    private lazy var popupStackView = UIStackView(arrangedSubviews: [topEmptyView]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
    }
    
    private let logobaseView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 29
        $0.backgroundColor = .white
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo_danting.png")
        $0.contentMode = .scaleAspectFill
    }
    
    private let topEmptyView = UIView()
    private let bottomEmptyView = UIView()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePopupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.backgroundView.transform = .identity
            self?.backgroundView.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.backgroundView.transform = .identity
            self?.backgroundView.isHidden = true
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PopupViewController {
    private func configurePopupVC() {
        self.view.backgroundColor = .clear
        self.view.addSubview(self.backgroundView)
        
        self.view.backgroundColor = .clear
        
        self.view.addSubviews(self.popupView, self.logobaseView)
        
        self.popupView.addSubviews(self.logobaseView, self.popupStackView)
        
        self.backgroundView.snp.makeConstraints { $0.edges.equalToSuperview()}
                
        self.logobaseView.addSubview(self.logoImageView)
        
        self.popupView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(319)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        self.popupStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.top.equalToSuperview()
            
        }
        
        self.logobaseView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(self.popupView.snp.top)
            $0.width.height.equalTo(63)
        }
        
        self.logoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(63)
        }
        
        self.topEmptyView.snp.makeConstraints { $0.height.equalTo(40) }
        
        self.bottomEmptyView.snp.makeConstraints { $0.height.equalTo(15) }
        

        
    }
    
    func addSubviewsToStackView(views: [UIView], spacing: CGFloat = 10,
                                bottomSpacing: CFloat = 15, topSpacing: CGFloat = 40,
                                completionHandler: @escaping(()->())) {
        DispatchQueue.main.async {
            self.popupStackView.spacing = spacing
            self.bottomEmptyView.snp.updateConstraints { $0.height.equalTo(bottomSpacing)}
            self.topEmptyView.snp.updateConstraints { $0.height.equalTo(topSpacing)}
            views.forEach { self.popupStackView.addArrangedSubview($0) }
            self.popupStackView.addArrangedSubview(self.bottomEmptyView)
            completionHandler()
        }
    }
    
    
    
}
