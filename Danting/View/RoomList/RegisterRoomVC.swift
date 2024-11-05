//
//  RegisterRoomVC.swift
//  Danting
//
//  Created by 김은상 on 10/25/24.
//

import UIKit
import SnapKit
import Then

final class RegisterRoomVC: UIViewController {
    //MARK: - Properties
    private let dantingLogoLabel = UILabel().then {
        $0.text = "DANTING"
        $0.font = UIFont(name: "Kodchasan-SemiBold", size: 32)
        $0.textColor = UIColor(hexCode: "5A80FD")
        $0.textAlignment = .center
    }
    
    private let roomTitleLabel = UILabel().then {
        $0.text = "방 제목"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    private let roomDescriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    private lazy var roomTitleTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.clearButtonMode = .whileEditing // 편집 중에 지우기 버튼 표시
        $0.delegate = self
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Regular", size: 13)! // Note the !
        ]
        $0.attributedPlaceholder = NSAttributedString(string: "   방 제목을 입력해주세요", attributes:attributes)
        
        
    }
    
    private let roomDescriptionView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
    }
    
    private lazy var roomDescriptionTextView = UITextView().then {
        $0.text = "방 설명을 입력해주세요. 최대 100자"
        $0.textColor = .lightGray
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.delegate = self
    }
    
    private let textCountLabel = UILabel().then {
        $0.textColor = UIColor(hexCode: "696E83")
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.text = "0/100"
        
    }
    
    private let meetingTypeLabel = UILabel().then {
        $0.text = "인원 선택"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private lazy var twoBytwoButton = UIButton().then {
        $0.setImage(UIImage(named: "twoBytwo")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(meetingTypeButtonDidTapped(_:)), for: .touchUpInside)
        $0.tag = 0
    }
    
    private lazy var threeBythreeButton = UIButton().then {
        $0.setImage(UIImage(named: "threeBythree")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(meetingTypeButtonDidTapped(_:)), for: .touchUpInside)
        $0.tag = 1
    }
    
    private lazy var fourByfourButton = UIButton().then {
        $0.setImage(UIImage(named: "fourByfour")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(meetingTypeButtonDidTapped(_:)), for: .touchUpInside)
        $0.tag = 2
    }
    
    private lazy var meetingTypeButtons = [self.twoBytwoButton, self.threeBythreeButton, self.fourByfourButton]
    
    private let registerButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.isEnabled = false
        $0.backgroundColor = UIColor(hexCode: "A8B1CE")
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
    }
    
    var myViewModel = MyViewModel()
    
    var maxParticipants: Int?
    private var selectedButtonTag: Int?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "방 만들기"
        self.view.backgroundColor = .white
        self.configureRegisterRoomVC()
        self.addGesture()
        
        // 버튼에 액션 추가
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }

    @objc private func registerButtonTapped() {
        let roomListViewController = RoomListViewController()
        self.navigationController?.pushViewController(roomListViewController, animated: true)
    }

    
    //MARK: - Helpers
    private func updateCharacterCount() {
        let characterCount = roomDescriptionTextView.text.count
        textCountLabel.text = "\(characterCount)/100"
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func updateButtonStyles() {
        for button in meetingTypeButtons {
            if button.tag == selectedButtonTag {
                // 선택된 버튼 스타일
                button.tintColor = .blue // 선택 시 색상
                button.layer.borderColor = UIColor.blue.cgColor // 선택 시 보더 색상
            } else {
                // 선택되지 않은 버튼 스타일
                button.tintColor = .black
                button.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
    private func validateInputs() {
        let isTitleEntered = !(roomTitleTextField.text?.isEmpty ?? true)
        let isDescriptionEntered = !(roomDescriptionTextView.text?.isEmpty ?? true)
        let isMeetingTypeSelected = maxParticipants != nil
        
        let isFormComplete = isTitleEntered && isDescriptionEntered && isMeetingTypeSelected
        self.registerButton.isEnabled = isFormComplete
        self.registerButton.backgroundColor = isFormComplete ? UIColor(hexCode: "5A80FD") : UIColor(hexCode: "A8B1CE")
    }
    
    //MARK: - Actions
    @objc func meetingTypeButtonDidTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.maxParticipants = 4
        case 1:
            self.maxParticipants = 6
        case 2:
            self.maxParticipants = 8
        default:
            break
        }
        self.selectedButtonTag = sender.tag
        updateButtonStyles()
        validateInputs()

    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        // 텍스트 필드의 텍스트 길이를 체크하고 버튼 활성화
        if let text = textField.text {
            // 10글자 이하인지 확인
            if text.count > 10 {
                // 10글자 초과 시 마지막 문자 제거
                textField.text = String(text.prefix(10))
            }
            
        }
        validateInputs()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension RegisterRoomVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == roomTitleTextField {
            roomDescriptionTextView.becomeFirstResponder()
        }
        return true
    }
}

extension RegisterRoomVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
        validateInputs()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "방 설명을 입력해주세요. 최대 100자" {
            textView.text = ""
            textView.textColor = .black // 실제 텍스트 색상
        }
    }
    
    // UITextViewDelegate 메서드 - 편집 끝날 시
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "방 설명을 입력해주세요. 최대 100자"
            textView.textColor = .lightGray // 플레이스홀더 색상
        }
    }
    
}


extension RegisterRoomVC {
    private func configureRegisterRoomVC() {
        self.view.addSubviews(self.dantingLogoLabel, self.roomTitleLabel, self.roomDescriptionLabel,
                              self.roomTitleTextField,self.roomDescriptionView,self.roomDescriptionTextView,
                              self.textCountLabel, self.meetingTypeLabel, self.twoBytwoButton,
                              self.threeBythreeButton, self.fourByfourButton, self.registerButton)
        
        
        // 로고 위치 설정
        dantingLogoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // 방 제목 레이블 위치 설정
        roomTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dantingLogoLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 방 제목 텍스트 필드 위치 설정
        roomTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(roomTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        // 방 설명 레이블 위치 설정
        roomDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(roomTitleTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 방 설명 텍스트 뷰 위치 설정
        roomDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(roomDescriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
        
        roomDescriptionTextView.snp.makeConstraints { make in
            make.edges.equalTo(roomDescriptionView).inset(10)
        }
        
        // 텍스트 카운트 레이블 위치 설정
        textCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(roomDescriptionView.snp.bottom).offset(-8)
            make.trailing.equalTo(roomDescriptionView).offset(-10)
        }
        
        // 인원 선택 레이블 위치 설정
        meetingTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(textCountLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 인원 선택 버튼들 위치 설정
        twoBytwoButton.snp.makeConstraints { make in
            make.top.equalTo(meetingTypeLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(81)
            make.width.equalTo(66)
        }
        
        threeBythreeButton.snp.makeConstraints { make in
            make.top.equalTo(twoBytwoButton)
            make.leading.equalTo(twoBytwoButton.snp.trailing).offset(21)
            make.height.equalTo(81)
            make.width.equalTo(97)
        }
        
        fourByfourButton.snp.makeConstraints { make in
            make.top.equalTo(twoBytwoButton)
            make.leading.equalTo(threeBythreeButton.snp.trailing).offset(19)
            make.height.equalTo(81)
            make.width.equalTo(126)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(680)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(55)
        }
        self.roomTitleTextField.becomeFirstResponder()
        
    }
}
