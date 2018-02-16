import Foundation
import UIKit
struct AlbumsForSearch {
    let artistName: String
    let collectionName: String
    let artworkUrl100: UIImage
    let trackCount: Int
    let primaryGenreName: String
    let releaseDate: String
    let collectionId: Int
    init(artistName: String, collectionName: String, artworkUrl100: UIImage,
         trackCount: Int, primaryGenreName: String, releaseDate: String, collectionId: Int) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.artworkUrl100 = artworkUrl100
        self.trackCount = trackCount
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        self.collectionId = collectionId
    }
}
