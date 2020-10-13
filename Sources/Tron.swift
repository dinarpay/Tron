import Foundation
import Combine

public final class Tron {
    private let queue = DispatchQueue(label: "", qos: .utility)
    
    public init() { }
    
    public func policy(for url: URL, shield: Bool) -> Future<Policy, Never> {
        .init { [weak self] result in
            self?.queue.async {
                let url = url.absoluteString
                if Self.equals.contains(url) {
                    result(.success(.deny))
                    return
                }
                if let schemeless = url.hasPrefix(Scheme.https.rawValue) ? url.dropFirst(8) :
                    url.hasPrefix(Scheme.http.rawValue) ? url.dropFirst(7) : nil {
                    if shield {
                        for item in schemeless.components(separatedBy: "/").first!.components(separatedBy: ".") {
                            guard Self.partial.contains(item) else { continue }
                            result(.success(.deny))
                            return
                        }
                        result(.success(.allow))
                    } else {
                        result(.success(.allow))
                    }
                }
                result(.success(.external))
            }
        }
    }
}
