import Foundation

var sessionConfig: URLSessionConfiguration = {
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = false
    configuration.waitsForConnectivity = false
    configuration.timeoutIntervalForRequest = 15.0
    configuration.timeoutIntervalForResource = 20.0
    return configuration
}()

public func getData(url: URL?) {
    var printingCount = 0
    let session = URLSession(configuration: sessionConfig)
    
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
            if card.name == "Opt" || card.name == "Black Lotus" {
                print("""
                    Имя карты - \(card.name)
                    Тип карты - \(card.type ?? "")
                    Редкость карты - \(card.rarity ?? "")
                    CMC - \(card.cmc ?? 0)
                    Количество манны - \(card.manaCost ?? "" )
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
""")
                printingCount += 1
            } else {
            }
        }
        print("""
Количество полученных карт: \(setCards.cards.count)
Количество отфильтрованных карт \(printingCount)
""")
    }.resume()
}

