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
    
    private let emptyView = UIView()
    
    lazy var popupStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
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
    func configurePopupVC() {
        self.view.backgroundColor = .clear
        self.view.addSubview(self.backgroundView)
        
        self.backgroundView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
}
