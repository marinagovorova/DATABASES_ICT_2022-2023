

import UIKit
import CoreData

class AddNoteViewController: UIViewController {


    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!


    var managedObjectContext: NSManagedObjectContext?


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        titleTextField.becomeFirstResponder()
    }


    @IBAction func save(sender: UIBarButtonItem) {
        guard let managedObjectContext = managedObjectContext else { return }
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(with: "Title Missing", and: "Your note doesn't have a title.")
            return
        }

        let note = Note(context: managedObjectContext)

        note.createdAt = Date()
        note.updatedAt = Date()
        note.title = titleTextField.text
        note.contents = contentsTextView.text

        _ = navigationController?.popViewController(animated: true)
    }

}
