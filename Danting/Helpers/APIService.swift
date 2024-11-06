import UIKit
import Alamofire

struct ServerResponse<T: Codable>: Codable {
    let success: Bool
    let result: T
}

enum DantingRouter {
    case getUser(user_id: Int)
    case createUser(nickName: String, student_no: String, major: String, gender: String)
    case getRoom(roomId: Int)
    case getRooms
    case createRoom(title: String, subTitle: String, users_id: Int, maxParticipants: Int)
    case enterRoom(users_id: Int, room_id: Int)
    case ready(users_id: Int, room_id: Int)
    case unready(users_id: Int, room_id: Int)
}

extension DantingRouter: URLRequestConvertible {
    
    var baseURL: URL {
        guard let url = URL(string: "http://49.247.47.0:8080") else { fatalError("baseURL Error") }
        return url
    }
    
    var path: String {
        switch self {
        case .getUser(let user_id):
            return "/users/\(user_id)"
            
        case .createUser(_, _, _, _):
            return "/join"
            
        case .getRoom(let room_id):
            return "/info/\(room_id)"
            
        case .getRooms:
            return "/all/list"
            
        case .createRoom(_, _, _, _):
            return "/create"
            
        case .enterRoom(_, _):
            return "/enter"
            
        case .ready(_, _):
            return "/ready"
        
        case .unready(_, _):
            return "/unready"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoom, .getRooms, .getUser:
            return .get
        case .createUser, .createRoom, .enterRoom, .ready, .unready:
            return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getRoom(_):
            return nil
        case .getRooms:
            return nil
        case .createRoom(let title, let subTitle, let users_id, let maxParticipants):
            return ["users_id": users_id,
                "title" : title, "subTitle" : subTitle, "maxParticipants" : maxParticipants]
        case .getUser(let user_id):
            return ["user_id" : user_id]
        case .createUser(let nickName, let student_no, let major, let gender):
            return ["nickName": nickName, "student_no" : student_no, "major"  : major, "gender" : gender]
        case .enterRoom(let users_id, let room_id):
            return ["users_id": users_id, "room_id": room_id]
        case .ready(let users_id, let room_id):
            return ["users_id": users_id, "room_id": room_id]
        case .unready(let users_id, let room_id):
            return ["users_id": users_id, "room_id": room_id]
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
        
        // 로그 출력
        print("======== Request ========")
        print("URL: \(urlRequest.url?.absoluteString ?? "")")
        print("Method: \(urlRequest.method?.rawValue ?? "")")
        print("Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
        if let body = urlRequest.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
        print("=========================")
        
        return urlRequest
    }
}

final class APIService {
    
    static let shared = APIService()
    private init() {}
    
    func getUser(user_id: Int, completion: @escaping (Result<ServerResponse<RoomDetailUserResponse>, Error>) -> Void) {
        request(router: .getUser(user_id: user_id), completion: completion)
    }
    
    func getRoom(roomId: Int, completion: @escaping (Result<ServerResponse<RoomDetailResponse>, Error>) -> Void) {
        request(router: .getRoom(roomId: roomId), completion: completion)
    }
    
    func getRooms(completion: @escaping (Result<ServerResponse<[RoomListItemResponse]>, Error>) -> Void) {
        request(router: .getRooms, completion: completion)
    }
    
    // MARK: - POST Requests
    

    func createUser(nickName: String, student_no: String, major: String, gender: String, completion: @escaping (Result<ServerResponse<JoinResponse>, Error>) -> Void) {
        request(router: .createUser(nickName: nickName, student_no: student_no, major: major, gender: gender), completion: completion)
    }
    
    func createRoom(user_id: Int, title: String, subTitle: String, max: Int, completion: @escaping (Result<ServerResponse<RoomListItemResponse>, Error>) -> Void) {
        request(router: .createRoom(title: title, subTitle: subTitle, users_id: user_id, maxParticipants: max), completion: completion)
    }
    
    func enterRoom(users_id: Int, room_id: Int, completion: @escaping (Result<ServerResponse<EnterRoomResponse>, Error>) -> Void) {
        request(router: .enterRoom(users_id: users_id, room_id: room_id), completion: completion)
    }
    
    func ready(users_id: Int, room_id: Int, completion: @escaping (Result<ServerResponse<Bool>, Error>) -> Void) {
        request(router: .ready(users_id: users_id, room_id: room_id), completion: completion)
    }
    
    
    func unready(users_id: Int, room_id: Int, completion: @escaping (Result<ServerResponse<Bool>, Error>) -> Void) {
        request(router: .unready(users_id: users_id, room_id: room_id), completion: completion)
    }
    
    private func request<T: Codable>(router: DantingRouter, completion: @escaping (Result<ServerResponse<T>, Error>) -> Void) {
        AF.request(router).responseDecodable(of: ServerResponse<T>.self, queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let serverResponse):
                print("Success:  + \(serverResponse)")
                completion(.success(serverResponse))
            case .failure(let error):
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                print("Error in responseDecodable: \(error)")
                completion(.failure(error))
            }
        }
    }
}
