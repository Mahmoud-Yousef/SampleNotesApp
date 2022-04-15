//
//  NotesRouter.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 MES. All rights reserved.
//

import UIKit

class NotesRouter: NSObject, PresenterToRouterProtocol_Notes, ViewToRouterProtocol_Notes {
    
    var view: RouterToViewProtocol_Notes?
    var addNoteAction = UIAlertAction()
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    static func createNotesModule() -> UIViewController {
        let navController = mainstoryboard.instantiateViewController(withIdentifier: StoryboardViewIDs.NOTES_NAVIGATION_CONTROLLER) as! UINavigationController
        let view = navController.topViewController as! NotesViewController
        
        let presenter: ViewToPresenterProtocol_Notes & InteractorToPresenterProtocol_Notes = NotesPresenter()
        let interactor: PresenterToInteractorProtocol_Notes = NotesInteractor()
        let router: PresenterToRouterProtocol_Notes & ViewToRouterProtocol_Notes = NotesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router as PresenterToRouterProtocol_Notes
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func newNoteAlert(id: Int, completion: @escaping (Note) -> (), randomHandler: @escaping () -> ()) {
        let newNoteAlert = UIAlertController(title: "New Note", message: nil, preferredStyle: .alert)
        newNoteAlert.addTextField { [unowned self] (titleField) in
            titleField.placeholder = "Title"
            titleField.delegate = self
        }
        newNoteAlert.addTextField { (contentField) in
            contentField.placeholder = "Content"
        }
        
        addNoteAction = UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let title = newNoteAlert.textFields?.first?.text, !title.isEmpty, let content = newNoteAlert.textFields?.last?.text else { return }
            
            let note = Note(id: id, title: title, content: content, isFavorite: false)
            completion(note)
        })
        addNoteAction.isEnabled = false
        newNoteAlert.addAction(addNoteAction)
        newNoteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        newNoteAlert.addAction(UIAlertAction(title: "Random", style: .default, handler: { (_) in
            randomHandler()
        }))
        view?.showAlert(alert: newNoteAlert)
    }
    
    func routeToNoteDetails(selectedNote: Note) {
        view?.showModule(view: NoteDetailsRouter.createNoteDetailsModule(selectedNote: selectedNote))
    }
}

extension NotesRouter: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            addNoteAction.isEnabled = (textField.text ?? "").count > 1
        } else {
            addNoteAction.isEnabled = !(textField.text?.appending(string) ?? "").isEmpty
        }
        
        return true
    }
}
