import UIKit

class Album: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var primaryGenreName: UILabel!
    @IBOutlet weak var trackCount: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let json = DownloadSongs()
    var image: UIImage?
    var artist: String = ""
    var album: String = ""
    var genre: String = ""
    var count: Int = 0
    var release: String = ""
    var albumID: Int = 0
    var tracks: [Songs] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getTracks()
        imageView.image = image
        self.title = album
        artistName.text = artist
        primaryGenreName.text = genre
        trackCount.text = "Count of tracks: " + String(count)
        releaseDate.text = "Release: " + String(release.prefix(10))
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
    }
    func commonInit(image: UIImage, artist: String, album: String, genre: String, count: Int, release: String, albumID: Int) {
        self.image = image
        self.artist = artist
        self.album = album
        self.genre = genre
        self.count = count
        self.release = release
        self.albumID = albumID
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as UITableViewCell!
        cell.textLabel?.text = tracks[indexPath.item].song
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func getTracks() {
        tracks.removeAll()
        json.download(collectionId: albumID) { [weak self] tracks in
            self?.tracks = tracks
            self?.tableView.reloadData()
        }
    }
}


