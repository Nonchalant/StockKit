import Foundation
import Finance
import Notification
import RxSwift
import PathKit
import Yaml

let args = ProcessInfo.processInfo.arguments

guard let path = args.dropFirst().first, let content: String = try? Path(path).read(), let conf = try? Yaml.load(content) else {
    NSLog("Load Error: conf.yml")
    exit(1)
}

let disposeBag = DisposeBag()
let finance = Finance(conf: conf["stocks"])
let sender = Sender(conf: conf["slack"])

finance.run()
    .flatMap {
        return sender.run(with: $0)
    }
    .subscribe(
        onSuccess: {
            exit(0)
        },
        onError: { error in
            NSLog(error.localizedDescription)
            exit(1)
        }
    )
    .disposed(by: disposeBag)

RunLoop.main.run()
