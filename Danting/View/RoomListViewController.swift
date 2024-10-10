//
//  RoomListViewController.swift
//  Danting
//
//  Created by 김은상 on 10/5/24.
//

// 방 목록 화면

import UIKit

final class RoomListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
        tableView.rowHeight = 100 /*UITableView.automaticDimension*/
        tableView.estimatedRowHeight = 100
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
    
    //MARK: - Helpers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomItemCell", for: indexPath) as! RoomItemCell
        
        cell.roomItemView.titleLabel.text = items[indexPath.row].0
        cell.roomItemView.subtitleLabel.text = items[indexPath.row].1
        
        return cell
    }
    
    //MARK: - Actions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(items[indexPath.row])")
    }

}
