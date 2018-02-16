import Foundation
class DecodeJSON {
    typealias dictionaryJSON = [String:Any]
    func getResult(data: Data) -> [dictionaryJSON] {
        guard let jsonOfResult = try? JSONSerialization.jsonObject(with: data, options: [])  as!  dictionaryJSON else {
            print("error in serialization")
            return []
        }
        guard let jsonALL = jsonOfResult["results"] as? [dictionaryJSON] else {
            print("error in serialization results")
            return []
        }
        return jsonALL
    }
    
}
