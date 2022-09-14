import Foundation

extension Encodable {
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let result = (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)).flatMap { $0 as? [String: Any] }
        
        if let result = result {
            return result
        } else {
            return [:]
        }
    }
}
