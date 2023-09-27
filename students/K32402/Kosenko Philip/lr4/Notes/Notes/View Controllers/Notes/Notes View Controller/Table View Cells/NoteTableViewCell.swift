
import UIKit

class NoteTableViewCell: UITableViewCell {


    static let reuseIdentifier = "NoteTableViewCell"


    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var updatedAtLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
