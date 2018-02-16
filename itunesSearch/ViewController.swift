import UIKit
class ViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    let cellID = "collectionViewCell"
    var albums: [AlbumsForSearch] = []
    typealias dictionaryJSON = [String:Any]
    let json = DownloadAlbums()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        self.title = "Album Searcher"
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CollectionViewCell
        cell?.commonInit(image: albums[indexPath.item].artworkUrl100)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = Album()
        guard indexPath.row < albums.count else { return }
        album.commonInit(image: albums[indexPath.item].artworkUrl100,
                         artist: albums[indexPath.item].artistName,
                         album: albums[indexPath.item].collectionName,
                         genre: albums[indexPath.item].primaryGenreName,
                         count: albums[indexPath.item].trackCount,
                         release: albums[indexPath.item].releaseDate,
                         albumID: albums[indexPath.item].collectionId)
        self.navigationController?.pushViewController(album, animated: true)
    }
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        guard let text = searchBar.text, !text.isEmpty else { return }
        let textEscaping = text.replacingOccurrences(of: " ", with: "+")
        json.download(searchName:textEscaping) { [weak self] albums in
            self?.albums = albums
            self?.albums.sort { $0.collectionName < $1.collectionName}
            self?.collectionView.reloadData()
        }
        return 
    }
    
}

