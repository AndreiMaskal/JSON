import Foundation

    var sessionConfig: URLSessionConfiguration = {
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = false
    configuration.waitsForConnectivity = false
    configuration.timeoutIntervalForRequest = 15.0
    configuration.timeoutIntervalForResource = 20.0
    return configuration
}()

    let session = URLSession(configuration: sessionConfig)

public func getData(nameCard: String) {
    let urlString = "https://api.magicthegathering.io/v1/cards/?name=\(nameCard)"
    
    let url = URL(string: urlString)
    guard let url = url else {
        print(NetworkError.badURL.errorInformation)
        return }
    
    session.dataTask(with: url) { data, response, error in
        guard error == nil else {
            print("DataTask error:" + "\(String(describing: error?.localizedDescription ?? ""))" + "\n")
            return
        }
        
        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Status code: \(String(describing: response.statusCode))")
        } else {
            print(NetworkError.serviceError.errorInformation)
            return
        }
        
        guard let data = data,
            let setCards = try? JSONDecoder().decode(Cards.self, from: data) else {
            print(NetworkError.badJSON.errorInformation)
            return
        }
        
        for card in setCards.cards {
            print("""
                    Имя карты - \(card.name)
                    Тип карты - \(card.type ?? "")
                    Редкость карты - \(card.rarity ?? "")
                    CMC - \(card.cmc ?? 0)
                    Количество манны - \(card.manaCost ?? "" )
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
""")
            
        }

    }.resume()
}

