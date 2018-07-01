import Foundation
import Yaml

struct Stock {
    let name: String
    let amount: Int
    let purchasedPrice: Double
    let code: Int
    
    init(yaml: Yaml) {
        guard let name = yaml["name"].string, let amount = yaml["amount"].int, let purchasedPrice = yaml["purchasedPrice"].double, let code = yaml["code"].int else {
            NSLog("Load Error: Stock(name, amount, purchasedPrice, code)")
            exit(1)
        }
        
        self.name = name
        self.amount = amount
        self.purchasedPrice = purchasedPrice
        self.code = code
    }
}
