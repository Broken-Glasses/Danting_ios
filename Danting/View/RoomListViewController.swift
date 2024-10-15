import UIKit
import SnapKit

final class RoomListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let floatingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(named: "ic_plus"), for: .normal) // 이미지 설정
        button.layer.cornerRadius = 27.5 // 버튼의 반지름을 크기에 맞게 설정
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.imageView?.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    let tableView = UITableView()
    let items = [("Room 1", "Description 1"), ("Room 2", "Description 2"), ("Room 3", "Description 3"), ("Room 4", "Description 4"), ("Room 5", "Description 5"), ("Room 6", "Description 6"), ("Room 7", "Description 7"), ("Room 8", "Description 8"), ("Room 9", "Description 9")]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "단팅 그룹"

        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RoomItemCell.self, forCellReuseIdentifier: "RoomItemCell")
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        self.view.addSubview(floatingButton)
        
        floatingButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.view.snp.trailing).offset(-20)
            make.bottom.equalTo(self.view.snp.bottom).offset(-35)
            make.width.height.equalTo(55)
        }

        // 버튼을 화면 맨 앞으로 가져옴
        self.view.bringSubviewToFront(floatingButton)
    }
    
    //MARK: - Helpers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomItemCell", for: indexPath) as! RoomItemCell
        cell.selectionStyle = .none
        cell.roomItemView.titleLabel.text = items[indexPath.row].0
        cell.roomItemView.subtitleLabel.text = items[indexPath.row].1
        
        return cell
    }
    
    //MARK: - Actions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(items[indexPath.row])")
        let attendingVC = AttendingViewController()
        attendingVC.modalPresentationStyle = .overFullScreen
        self.present(attendingVC, animated: true, completion: nil)
        
    }

}
