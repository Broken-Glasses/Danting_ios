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
    
    private let personGenderLabel = UILabel().then {
        $0.text = "성별"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    private let personIDField = UITextField().then {
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Regular", size: 13)!
        ]
        $0.attributedPlaceholder = NSAttributedString(string: " 학번을 입력해주세요. ex)32190111", attributes:attributes)
    }
    
    private let personMajorField = UITextField().then {
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Regular", size: 13)!
        ]
        $0.attributedPlaceholder = NSAttributedString(string: " 학과를 선택해주세요", attributes:attributes)
    }
    
    private let majorPicker = UIPickerView()
    
    private let majors = ["국어국문학과", "사학과", "철학과", "영미인문학과", "법학과", "정치외교학과", "행정학과", "도시계획부동산학부", "미디어커뮤니케이션학부","상담학과",
                          "경제학과", "무역학과", "경영학부", "산업경영학과(야)", "글로벌경영학과",
                          "전자전기공학과", "융합반도체공학과", "고분자시스템공학부", "토목환경공학과", "기계공학과", "화학공학과", "건축학부",
                          "소프트웨어학과", "컴퓨터공학과", "모바일시스템공학과", "통계데이터사이언스학과", "사이버보안학과", "SW융합학부",
                          "한문교육과", "특수교육과", "수학교육과", "과학교육과", "체육교육과", "교직교육과",
                          "도예과", "디자인학부", "공연영화학부", "무용과", "음악학부",
                          "아시아중동학부", "유럽중남미학부", "영어과", "글로벌한국어과",
                          "수학과", "물리학과", "화학과", "식품영양학과", "신소재공학과", "에너지공학과", "경영공학과", "제약공학과",
                          "생명자원학부", "의생명과학부", "식품공학과", "코스메디컬소재학과",
                          "미술학부", "문예창작과", "뉴뮤직학부",
                          "생활체육학과", "스포츠경영학과", "국제스포츠학부",
                          "의예과", "의학과",
                          "공공정책학과","공공정책학과(야)", "사회복지학과", "해병대군사학과", "식품자원경제학과",
                          "임상병리학과", "물리치료학과", "보건행정학과", "치위생학과", "심리치료학과",
                          "간호학과",
                          "치의예과", "치의학과",
                          "약학과"]
    
    private let maleButton = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.layer.cornerRadius = 14
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexCode: "CEDEFF").cgColor
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let femaleButton = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.layer.cornerRadius = 14
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexCode: "CEDEFF").cgColor
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    private lazy var personInfoConfirmButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.isEnabled = false
        $0.backgroundColor = UIColor(hexCode: "A8B1CE")
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        $0.addTarget(self, action: #selector(confirmButtonDidTapped), for: .touchUpInside)
    }
    
    // 학번 필드의 체크마크와 엑스마크
    private let personIDCheckmarkImageView = UIImageView(image: UIImage(named: "checkmark")).then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    private let personIDXmarkImageView = UIImageView(image: UIImage(named: "xmark")).then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = false       }
    
    // 학과 필드의 체크마크와 엑스마크
    private let personMajorCheckmarkImageView = UIImageView(image: UIImage(named: "checkmark")).then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    private let personMajorXmarkImageView = UIImageView(image: UIImage(named: "xmark")).then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = false
    }
    
    private var isIDValid = false
    private var isMajorSelected = false
    private var isGenderSelected = false
    
    var nickName: String?
    var gender: String?
    
    let myViewModel = MyViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configurePersonInfoUI()
        self.settingPicker()
        self.settingButtons()
        self.settingTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        personIDField.becomeFirstResponder() // personIDField에 키보드 표시
    }
    
    deinit {
        // 옵저버 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Helpers
    private func updateConfirmButtonState() {
        // personIDField가 숫자 8자리인지 확인
        let isIDValid = isValidID(personIDField.text ?? "")
        // majorField의 값이 있는지 확인
        let isMajorFieldValid = !(personMajorField.text?.isEmpty ?? true)
        // gender 값이 있는지 확인
        let isGenderValid = gender != nil
        
        // 모든 조건을 만족하면 확인 버튼 활성화
        
        let isFormValid = isIDValid && isMajorFieldValid && isGenderValid
        if isFormValid {
            personInfoConfirmButton.isEnabled = isFormValid
            personInfoConfirmButton.backgroundColor = UIColor(hexCode: "5A80FD")
        }
    }
    
    private func isValidID(_ id: String) -> Bool {
        let idPredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{8}$")
        return idPredicate.evaluate(with: id)
    }
    
    
    //MARK: - Actions
    @objc func confirmButtonDidTapped() {
        self.view.endEditing(true) // 다른 곳을 터치하면 키보드를 내림
        guard let nickName = self.nickName,
              let student_no = self.personIDField.text,
              let major = self.personMajorField.text,
              let gender = self.gender else { return }
        self.myViewModel.createUser(nickName: nickName, student_no: student_no, major: major, gender: gender) {
            DispatchQueue.main.async {
                if let navigationController = self.navigationController {
                    let roomListVC = RoomListViewController()
                    navigationController.setViewControllers([roomListVC], animated: true)
                }
            }
        }
    }
    
    
    @objc func genderButtonTapped(_ sender: UIButton) -> String? {
        if sender == maleButton {
            maleButton.backgroundColor = UIColor(hexCode: "CEDEFF")
            maleButton.setTitleColor(.black, for: .normal)
            femaleButton.backgroundColor = .white
            femaleButton.setTitleColor(.black, for: .normal)
            isGenderSelected = true // 성별 선택 상태 업데이트
            self.gender = "male"
        } else {
            femaleButton.backgroundColor = UIColor(hexCode: "CEDEFF")
            femaleButton.setTitleColor(.black, for: .normal)
            maleButton.backgroundColor = .white
            maleButton.setTitleColor(.black, for: .normal)
            isGenderSelected = true // 성별 선택 상태 업데이트
            self.gender = "female"
        }
        updateConfirmButtonState() // 상태 업데이트
        return gender
    }
}

extension PersonInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majors.count
    }
    
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majors[row] // 전공 리스트의 각 항목을 반환
    }
    
    // 선택된 전공을 텍스트 필드에 설정하는 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        personMajorField.text = majors[row]
        personMajorCheckmarkImageView.isHidden = false
        personMajorXmarkImageView.isHidden = true
        isMajorSelected = true
        updateConfirmButtonState()
        personMajorField.resignFirstResponder()
    }
}

extension PersonInfoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        if updatedText.count > 8 || (string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil && !updatedText.isEmpty) {
            self.personIDXmarkImageView.isHidden = false
            self.personIDCheckmarkImageView.isHidden = true
            return false
        }
        
        // 8글자일 경우 personMajorField로 포커스 이동
        if updatedText.count == 8 {
            self.personIDXmarkImageView.isHidden = true
            self.personIDCheckmarkImageView.isHidden = false
            self.personIDField.text = currentText + String(updatedText.last!)
            personMajorField.becomeFirstResponder()
        }
        
        updateConfirmButtonState()
        return true
    }

}




//MARK: - Extension_BasicSetting
extension PersonInfoViewController {
    
    private func configurePersonInfoUI() {
        self.title = "기본정보"
        self.view.addSubviews(self.dantingLogoLabel, self.personIDLabel, self.personMajorLabel, self.personIDField, self.personMajorField,
                              self.personGenderLabel, self.maleButton, self.femaleButton, self.personInfoConfirmButton)
        
        self.dantingLogoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        personIDLabel.snp.makeConstraints { make in
            make.top.equalTo(dantingLogoLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        personIDField.snp.makeConstraints { make in
            make.top.equalTo(personIDLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        personMajorLabel.snp.makeConstraints { make in
            make.top.equalTo(personIDField.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(20)
        }
        
        personMajorField.snp.makeConstraints { make in
            make.top.equalTo(personMajorLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        personGenderLabel.snp.makeConstraints { make in
            make.top.equalTo(personMajorField.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        maleButton.snp.makeConstraints { make in
            make.centerY.equalTo(personGenderLabel.snp.centerY)
            make.leading.equalTo(personGenderLabel.snp.trailing).offset(70)
            make.width.equalTo(71)
            make.height.equalTo(28)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(personGenderLabel.snp.centerY)
            make.leading.equalTo(maleButton.snp.trailing).offset(59)
            make.width.equalTo(71)
            make.height.equalTo(28)
        }
        
        personInfoConfirmButton.snp.makeConstraints { make in
            make.top.equalTo(self.maleButton.snp.bottom).offset(39)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
    }
    
    private func settingPicker() {
        // Picker 설정
        majorPicker.delegate = self
        majorPicker.dataSource = self
        personMajorField.inputView = majorPicker // 텍스트 필드에 picker 뷰를 input으로 설정
        
        personIDField.delegate = self
        personMajorField.delegate = self
    }
    
    private func settingButtons() {
        // 성별 버튼 액션 추가
        maleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        
        // 초기 상태 설정
        maleButton.backgroundColor = .white
        femaleButton.backgroundColor = .white
        maleButton.setTitleColor(.black, for: .normal)
        femaleButton.setTitleColor(.black, for: .normal)
    }
    
    private func settingTextField() {
        // mark표시 설정
        personIDField.rightView = UIStackView(arrangedSubviews: [personIDCheckmarkImageView, personIDXmarkImageView]).then {
            $0.axis = .horizontal
            $0.translatesAutoresizingMaskIntoConstraints = false
            // UIStackView의 너비를 제한하여 오른쪽으로 여백을 추가
            $0.widthAnchor.constraint(equalToConstant: 40).isActive = true // 전체 너비
        }
        personIDField.rightViewMode = .always
        
        personMajorField.rightView = UIStackView(arrangedSubviews: [personMajorCheckmarkImageView, personMajorXmarkImageView]).then {
            $0.axis = .horizontal
            $0.translatesAutoresizingMaskIntoConstraints = false
            // UIStackView의 너비를 제한하여 오른쪽으로 여백을 추가
            $0.widthAnchor.constraint(equalToConstant: 40).isActive = true // 전체 너비

        }
        personMajorField.rightViewMode = .always
    }
}




