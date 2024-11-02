//
//  API.swift
//  Danting
//
//  Created by 김은상 on 10/28/24.
//

import UIKit
import Alamofire

struct ServerResponse: Codable {
    let isSuccess: Bool
    let result: ResultData
}

struct ResultData: Codable {
    let user_id: String
    let room_id: String
    let room: Room
}

enum DantingRouter {
    case getUser(user_id: Int)
    case createUser(nickName: String, student_no: Int, gender: String, major: String)
    case getRoom(rood_id: Int)
    case getRooms
    case createRoom(title: String, subTitle: String, user_id: String, maxParticipants: Int)
    case attendRoom(room_id: Int, user_id: Int)
    case ready(room_id: Int, user_id: Int)
}


extension DantingRouter: URLRequestConvertible {
    
    
    
    var baseURL: URL {
        guard let url = URL(string: "베이스 URL") else { fatalError("baseURL Error") }
        return url
    }
    
    var path: String {
        switch self {
        case .getUser(let user_id):
            return "/users/\(user_id)"
            
        case .createUser(_, _, _, _):
            return "/users"
            
        case .getRoom(let room_id):
            return "/info/\(room_id)"
            
        case .getRooms:
            return "/rooms"
            
        case .createRoom(_, _, _, _):
            return "/create"
            
        case .attendRoom(_, _):
            return "/enter"
            
        case .ready(_, _):
            return "/ready"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoom, .getRooms, .getUser:
            return .get
        case .createRoom, .createUser, .ready, .attendRoom:
            return .post
        }
    }
    var parameters: Parameters? {
        switch self {
        case .getRoom(let room_id):
            return ["room_id": room_id]
        case .getRooms:
            return nil
        case .createRoom(let title, let subTitle, let participants, let maxParticipants):
            return ["title" : title, "subTitle" : subTitle, "participants" : participants, "maxParticipants" : maxParticipants]
        case .getUser(let user_id):
            return ["user_id" : user_id]
        case .createUser(let nickName, let student_no, let major, let gender):
            return ["nickName" : nickName, "student_no" : student_no, "major"  : major, "gender" : gender]
        case .ready(let room_id, let user_id):
            return ["room_id" : room_id, "user_id" : user_id]
        case .attendRoom(let room_id, let user_id):
            return ["room_id" : room_id, "user_id" : user_id]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}

final class APIService {
    
    static let shared = APIService()
    private init() {}
    
    //MARK: - GET
    func getUserInGlobalQueue(user_id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request(DantingRouter.getUser(user_id: user_id)).responseDecodable(of: User.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRoom(room_id: Int, completion: @escaping(Result<Room, Error>) -> Void) {
        AF.request(DantingRouter.getRoom(rood_id: room_id)).responseDecodable(of: Room.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let room):
                completion(.success(room))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRooms(completion: @escaping(Result<[Room], Error>) -> Void) {
        AF.request(DantingRouter.getRooms).responseDecodable(of: [Room].self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let rooms):
                completion(.success(rooms))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    //MARK: - POST
    
    func createUser(nickName: String, student_no: Int, major: String, gender: String, completion: @escaping (Result<User, Error>) -> Void) {
        AF.request(DantingRouter.createUser(nickName: nickName, student_no: student_no, gender: gender, major: major)).responseDecodable(of: User.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func createRoom(user_id: String, title: String, subTitle: String, max: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        AF.request(DantingRouter.createRoom(title: title, subTitle: subTitle, user_id: user_id, maxParticipants: max)).responseDecodable(of: Int.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let room_id):
                completion(.success(room_id))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func ready(user_id: Int, room_id: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        AF.request(DantingRouter.ready(room_id: room_id, user_id: user_id)).responseDecodable(of: Bool.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let isReady):
                completion(.success(isReady))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func attendRoom(user_id: Int, room_id: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        AF.request(DantingRouter.attendRoom(room_id: room_id, user_id: user_id)).responseDecodable(of: Int.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let room_id):
                completion(.success(room_id))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}




