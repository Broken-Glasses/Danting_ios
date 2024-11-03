import UIKit
import SnapKit

final class PersonInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    private lazy var personIDField = UITextField().then {
//        $0.placeholder = "학번을 입력해주세요. ex)32190111"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        
        $0.delegate = self
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Regular", size: 13)! // Note the !
        ]
        $0.attributedPlaceholder = NSAttributedString(string: " 학번을 입력해주세요. ex)32190111", attributes:attributes)
    }
    
    private lazy var personMajorField = UITextField().then {
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hexCode: "5A80FD").cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.delegate = self
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Regular", size: 13)! // Note the !
        ]
        $0.attributedPlaceholder = NSAttributedString(string: " 학과를 선택해주세요", attributes:attributes)
    }
    
    private let majorPicker = UIPickerView()
    
    private let majors = ["국어국문학과", "사학과", "철학과", "영미인문학과",
                          "법학과",
                          "정치외교학과", "행정학과", "도시계획부동산학부", "미디어커뮤니케이션학부","상담학과",
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

    var nickName: String?
    
    let myViewModel = MyViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configurePersonInfoUI()
        
        // Picker 설정
        majorPicker.delegate = self
        majorPicker.dataSource = self
        personMajorField.inputView = majorPicker // 텍스트 필드에 picker 뷰를 input으로 설정
    }
}


extension PersonInfoViewController: UITextFieldDelegate {
    
}

extension PersonInfoViewController {
    private func configurePersonInfoUI() {
        self.title = "기본정보"
        self.view.addSubviews(self.dantingLogoLabel, self.personIDLabel, self.personMajorLabel, self.personIDField, self.personMajorField)
        
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
            make.top.equalTo(personIDField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        personMajorField.snp.makeConstraints { make in
            make.top.equalTo(personMajorLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majors.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        personMajorField.text = majors[row]
        personMajorField.resignFirstResponder() // picker 뷰 닫기
    }
}



