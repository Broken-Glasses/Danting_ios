import UIKit
import Alamofire

struct ServerResponse<T: Codable>: Codable {
    let success: Bool
    let result: T
}

enum DantingRouter {
    case getUser(user_id: Int)
    case createUser(nickName: String, student_no: String, gender: String, major: String)
    case getRoom(room_id: Int)
    case getRooms
    case createRoom(title: String, subTitle: String, user_id: Int, maxParticipants: Int)
    case attendRoom(room_id: Int, user_id: Int)
    case ready(room_id: Int, user_id: Int)
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
        case .createUser, .createRoom, .ready, .attendRoom:
            return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getRoom(let room_id):
            return nil
        case .getRooms:
            return nil
        case .createRoom(let title, let subTitle, let participants, let maxParticipants):
            return ["title" : title, "subTitle" : subTitle, "participants" : participants, "maxParticipants" : maxParticipants]
        case .getUser(let user_id):
            return ["user_id" : user_id]
        case .createUser(let nickName, let student_no, let major, let gender):
            return ["nickName": nickName, "student_no" : student_no, "major"  : major, "gender" : gender]
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
    
    func getUser(user_id: Int, completion: @escaping (Result<ServerResponse<RoomDetailUserResponse>, Error>) -> Void) {
        request(router: .getUser(user_id: user_id), completion: completion)
    }
    
    func getRoom(room_id: Int, completion: @escaping (Result<ServerResponse<RoomDetailResponse>, Error>) -> Void) {
        request(router: .getRoom(room_id: room_id), completion: completion)
    }
    
    func getRooms(completion: @escaping (Result<ServerResponse<[RoomListItemResponse]>, Error>) -> Void) {
        request(router: .getRooms, completion: completion)
    }
    
    // MARK: - POST Requests
    

    func createUser(nickName: String, student_no: String, major: String, gender: String, completion: @escaping (Result<ServerResponse<JoinResponse>, Error>) -> Void) {
        request(router: .createUser(nickName: nickName, student_no: student_no, gender: gender, major: major), completion: completion)
    }
    
    func createRoom(user_id: Int, title: String, subTitle: String, max: Int, completion: @escaping (Result<ServerResponse<Int>, Error>) -> Void) {
        request(router: .createRoom(title: title, subTitle: subTitle, user_id: user_id, maxParticipants: max), completion: completion)
    }
    
    func ready(user_id: Int, room_id: Int, completion: @escaping (Result<ServerResponse<Bool>, Error>) -> Void) {
        request(router: .ready(room_id: room_id, user_id: user_id), completion: completion)
    }
    
    func attendRoom(user_id: Int, room_id: Int, completion: @escaping (Result<ServerResponse<Int>, Error>) -> Void) {
        request(router: .attendRoom(room_id: room_id, user_id: user_id), completion: completion)
    }
    
    private func request<T: Codable>(router: DantingRouter, completion: @escaping (Result<ServerResponse<T>, Error>) -> Void) {
        AF.request(router).responseDecodable(of: ServerResponse<T>.self) { response in
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
