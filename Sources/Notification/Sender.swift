import Finance
import Foundation
import RxSwift
import SlackKit
import Yaml

public class Sender {
    private let bot: SlackKit
    private let channel: String
    private let username: String
    
    public init(conf: Yaml) {
        guard let token = conf["token"].string, let channel = conf["channel"].string, let username = conf["username"].string else {
            NSLog("Load Error: token, channel, username")
            exit(1)
        }
        
        self.bot = SlackKit()
        bot.addWebAPIAccessWithToken(token)
        self.channel = channel
        self.username = username
    }
    
    public func run(with results: [Result]) -> Single<Void> {
        return Single<Void>.create { (observer) -> Disposable in
            self.bot.webAPI?.sendMessage(
                channel: self.channel,
                text: "",
                username: self.username,
                asUser: true,
                attachments: self.attachments(results: results),
                success: { (ts, channel) in
                    NSLog(ts ?? "")
                    observer(.success(()))
                },
                failure: { error in
                    observer(.error(error))
                }
            )
            
            return Disposables.create()
        }
    }
    
    private func attachments(results: [Result]) -> [Attachment] {
        let amount = results.map({ $0.amount }).reduce(0, +)
        let total = results.map({ $0.total }).reduce(0, +)
        let balance = results.map({ ($0.current - $0.purchasedPrice) * Double($0.amount) }).reduce(0, +)
        let attachments: [Attachment] = results.map({
            attachment(name: $0.name, amount: $0.amount, balance: ($0.current - $0.purchasedPrice) * Double($0.amount), total: $0.total)
        })
        
        return [attachment(name: "Total", amount: amount, balance: balance, total: total)] + attachments
    }
    
    private func attachment(name: String, amount: Int, balance: Double, total: Double) -> Attachment {
        return Attachment(attachment: [
            "author_name": name,
            "color": balance >= 0 ? "#7CD197" : "#F35A00",
            "fields": [
                [
                    "title": "Amount",
                    "value": format(with: NSNumber(integerLiteral: amount), style: .decimal),
                    "short": true
                ],
                [
                    "title": "Market Value",
                    "value": format(with: NSNumber(floatLiteral: total), style: .currency),
                    "short": true
                ],
                [
                    "title": "Evaluation",
                    "value": format(with: NSNumber(floatLiteral: balance), style: .currency),
                    "short": true
                ]
            ]
            ])
    }
    
    private func format(with number: NSNumber, style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.numberStyle = style
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter.string(from: number) ?? ""
    }
}
