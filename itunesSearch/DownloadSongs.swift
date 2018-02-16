import Foundation
class DownloadSongs {
    let searchUrl = "https://itunes.apple.com/lookup?id="
    typealias dictionaryJSON = [String:Any]
    var songs: [Songs] = []
    let decode = DecodeJSON()
    func download(collectionId: Int, finished: @escaping (([Songs])->Void)){
        let group = DispatchGroup()
        guard let jsonURL = URL(string: searchUrl + String(collectionId) + "&entity=song") else {
            print("error in name")
            return
        }
        URLSession.shared.dataTask(with: jsonURL, completionHandler: { (data, _, error) in
            guard let data = data
                else {
                    print("no internet")
                    return
            }
            let jsonALL: [dictionaryJSON] = self.decode.getResult(data: data)
            let jsonExeptFirst = jsonALL.dropFirst()
            for single in jsonExeptFirst {
                group.enter()
                guard let song = single["trackName"] as? String else {
                        print("error in Name of track")
                        return
                }
                self.songs.append(Songs(song: song))
                group.leave()
            }
            group.notify(queue: .main, execute: {
                finished(self.songs)
                self.songs.removeAll()
            })
        }).resume()
        
    }
    
}
