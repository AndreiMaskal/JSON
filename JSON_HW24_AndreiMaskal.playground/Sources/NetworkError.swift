import Foundation

public enum NetworkError: Error {
    case badJSON
    case badURL
    case serviceError
    
    var errorInformation: String {
        switch self {
        case .badURL:
            return "неверный адрес"
        case .badJSON:
            return "неверный JSON"
        case .serviceError:
            return "нет ответа сервера, попробуйте позже"
        }
    }
}


