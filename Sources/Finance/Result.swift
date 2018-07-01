public struct Result {
    public let name: String
    public let amount: Int
    public let purchasedPrice: Double
    public let current: Double
    
    public var total: Double {
        return Double(amount) * current
    }
    
    init(stock: Stock, current: Double) {
        self.name = stock.name
        self.amount = stock.amount
        self.purchasedPrice = stock.purchasedPrice
        self.current = current
    }
}
