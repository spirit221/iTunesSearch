import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func commonInit(image: UIImage) {
        imageCell.image = image
    }
}
