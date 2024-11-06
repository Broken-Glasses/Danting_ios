//
//  MyViewModel.swift
//  Danting
//
//  Created by 김은상 on 10/22/24.
//

import UIKit


final class MyViewModel {
    //MARK: - Model
    
    let apiService = APIService.shared
    
    var room: RoomDetailResponse? {
        didSet {
            guard let room = self.room else { return }
            didFetchRoom?(room)
        }
    }
    

    var rooms: [RoomDetailResponse]? {
        didSet {
            guard let rooms = self.rooms else { return }
        }
    }
    
    var roomList: [RoomListItemResponse]? {
        didSet {
            guard let roomList = self.roomList else { return }
            didFetchRoomList?()
        }
    }
    
    var didFetchRoomList: (()->(Void))?

    var didFetchRoom: ((RoomDetailResponse) ->(Void))?
    
    var didFetchRooms: (([RoomDetailResponse])->(Void))?
    
    
    func getRooms() {
        apiService.getRooms { serverResponse in
            switch serverResponse {
            case .success(let result):
                self.roomList = result.result
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func createRoom(title: String, subTitle: String, user_id: Int, maxParticipants: Int, completionHandler: @escaping((Int)->Void)) {
        
        APIService.shared.createRoom(user_id: user_id, title: title, subTitle: subTitle, max: maxParticipants) { serverResponse in
            switch serverResponse {
            case .success(let result):
                completionHandler(result.result.room_id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func createUser(nickName: String, student_no: String, major: String, gender: String, completionHandler: @escaping () -> Void) {
        apiService.createUser(nickName: nickName, student_no: student_no, major: major, gender: gender) { serverResponse in
            switch serverResponse {
            case .success(let result):
                let user_id = result.result.userId // 직접 사용
                UserDefaults.standard.setValue(user_id, forKey: userIdKey)
                print(result)
                completionHandler()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func createRoom(user_id: Int, title: String, subTitle: String, maxParticipants: Int, completetionHandler: @escaping (Int) -> Void) {
        apiService.createRoom(user_id: user_id, title: title, subTitle: subTitle, max: maxParticipants, completion: { serverResponse in
            switch serverResponse {
            case .success(let result):
                completetionHandler(result.result.room_id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func enterRoom(users_id: Int, room_id: Int, completionHandler: @escaping (Int) -> Void) {
        apiService.enterRoom(users_id: users_id, room_id: room_id) { serverResponse in
            switch serverResponse {
            case .success(let result):
                completionHandler(result.result.room_id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func ready(users_id: Int, room_id: Int, completionHandler: @escaping (Int) -> Void) {
        apiService.ready(users_id: users_id, room_id: room_id) { serverResponse in
            switch serverResponse {
            case .success(let result):
                completionHandler(users_id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func unready(users_id: Int, room_id: Int, completionHandler: @escaping (Int) -> Void) {
        apiService.unready(users_id: users_id, room_id: room_id) { serverResponse in
            switch serverResponse {
            case .success(let result):
                completionHandler(users_id)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getRoomDetail(roomId: Int, completetionHandler: @escaping (RoomDetailResponse) -> Void) {
        apiService.getRoom(room_id: roomId, completion: { serverResponse in
            switch serverResponse {
            case .success(let result):
                self.room = result.result
                completetionHandler(result.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        })
    }

}

