//
//  NoteDetailsViewController.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/8/19.
//  Copyright © 2019 MES. All rights reserved.
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var presenter: ViewToPresenterProtocol_NoteDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.showNote()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.editNote(title: titleTextField.text ?? "", content: contentTextView.text)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteDetailsViewController: PresenterToViewProtocol_NoteDetails {
    func displayNote(title: String, content: String) {
        titleTextField.text = title
        contentTextView.text = content
    }
}
