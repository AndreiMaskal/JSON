import Foundation

let masterServerURL = "https://api.magicthegathering.io"
let urlPath = "/v1/cards"

var queryItem = [URLQueryItem(name: "name", value: "Black Lotus|Opt")]

let cardsUrl = makeRequestUrl(masterUrl: masterServerURL,
                              path: urlPath,
                              queryItems: queryItem)

getData(url: cardsUrl)


