import Foundation
import RxSwift
import Yaml

public class Finance {
    private let stocks: [Stock]
    
    public init(conf: Yaml) {
        guard let stocks = conf.array?.map(Stock.init) else {
            NSLog("Load Error: stocks")
            exit(1)
        }
        
        self.stocks = stocks
    }
    
    public func run() -> Single<[Result]> {
        return Single.zip(stocks.map(fetch))
    }
    
    private func fetch(stock: Stock) -> Single<Result> {
        guard let url = URL(string: "https://www.google.com/finance/getprices?q=\(stock.code)&x=TYO&i=86400&p=3d&f=c") else {
            return Single.error(Error.unknown)
        }
        
        return Single<Result>.create { (observer) -> Disposable in
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data, let text = String(data: data, encoding: .utf8) else {
                    observer(.error(error ?? Error.unknown))
                    return
                }
                
                let current = Double(String(text.split(separator: "\n").last ?? "")) ?? 0
                observer(.success(Result(stock: stock, current: current)))
            }.resume()
            
            return Disposables.create()
        }
    }
}
