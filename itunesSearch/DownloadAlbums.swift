import Foundation
import UIKit
class DownloadAlbums {
    let searchUrl = "https://itunes.apple.com/search?term="
    typealias dictionaryJSON = [String:Any]
    var albums: [AlbumsForSearch] = []
    let decode = DecodeJSON()
    func download(searchName: String, finished: @escaping (([AlbumsForSearch])->Void)){
        let group = DispatchGroup()
        self.albums.removeAll()
        guard let jsonURL = URL(string: searchUrl + searchName + "&entity=album&attribute=albumTerm") else {
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
            for single in jsonALL {
                guard let artistName = single["artistName"] as? String,
                    let collectionName = single["collectionName"] as? String,
                    let artworkUrl = single["artworkUrl100"] as? String,
                    let url = URL(string: artworkUrl),
                    let trackCount = single["trackCount"] as? Int,
                    let primaryGenreName = single["primaryGenreName"] as? String,
                    let releaseDate = single["releaseDate"] as? String,
                    let collectionId = single["collectionId"] as? Int else {
                        print("error in json[artistName]")
                        return
                }
                group.enter()
                URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
                    guard let data = data, let artworkUrl100 = UIImage(data: data) else { return }
                    self.albums.append(AlbumsForSearch(artistName: artistName, collectionName: collectionName, artworkUrl100: artworkUrl100, trackCount: trackCount, primaryGenreName: primaryGenreName, releaseDate: releaseDate, collectionId: collectionId))
                    group.leave()
                }).resume()
                group.notify(queue: .main, execute: {
                    finished(self.albums)
                })
            }
        }).resume()
        
    }
}
