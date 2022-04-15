//
//  ViewController.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 MES. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    private var notes: [Note] = []
    var presenter: ViewToPresenterProtocol_Notes?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.loadNotes()
    }
}

extension NotesViewController {
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presenter?.addNote()
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showNoteDetails(selectedNote: notes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.presenter?.removeNote(id: self.notes[indexPath.row].id)
            self.notes.remove(at: indexPath.row)
            self.notesTableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}

extension NotesViewController: PresenterToViewProtocol_Notes {
    func viewNotes(notes: [Note]) {
        self.notes = notes
        
        DispatchQueue.main.async {
            self.notesTableView.reloadData()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension NotesViewController: RouterToViewProtocol_Notes {
    func showAlert(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func showModule(view: UIViewController) {
        show(view, sender: nil)
    }
}
