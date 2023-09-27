

import UIKit

class NoteViewController: UIViewController {


    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!


    var note: Note?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Note"

        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Update Note
        if let title = titleTextField.text, !title.isEmpty {
            note?.title = title
        }

        note?.updatedAt = Date()
        note?.contents = contentsTextView.text
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }


    private func setupView() {
        setupTitleTextField()
        setupContentsTextView()
    }


    private func setupTitleTextField() {
        titleTextField.text = note?.title
    }

    private func setupContentsTextView() {
        contentsTextView.text = note?.contents
    }

}
