//
//  Protocols.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 MES. All rights reserved.
//

import UIKit

protocol PresenterToViewProtocol_Notes: AnyObject {
    func viewNotes(notes: [Note])
    func showAlert(message: String)
}

protocol ViewToPresenterProtocol_Notes: AnyObject {
    var view: PresenterToViewProtocol_Notes? { get set }
    var interactor: PresenterToInteractorProtocol_Notes? { get set }
    var router: PresenterToRouterProtocol_Notes? { get set }
    
    func addNote()
    func loadNotes()
    func showNoteDetails(selectedNote: Note)
    func removeNote(id: Int)
}

protocol PresenterToInteractorProtocol_Notes: AnyObject {
    var presenter: InteractorToPresenterProtocol_Notes? { get set }
    
    func saveNote(note: Note)
    func fetchNotes()
    func fetchRandomTitle()
    func deleteNote(id: Int)
}

protocol InteractorToPresenterProtocol_Notes: AnyObject {
    func notesFetched(notes: [Note])
    func randomTitleFetched(title: String)
    func randomTitleFetchFailed()
}

protocol PresenterToRouterProtocol_Notes: AnyObject {
    static func createNotesModule() -> UIViewController
    func newNoteAlert(id: Int, completion: @escaping (Note) -> (), randomHandler: @escaping () -> ())
    func routeToNoteDetails(selectedNote: Note)
}

protocol ViewToRouterProtocol_Notes: AnyObject {
    var view: RouterToViewProtocol_Notes? { get set }
}

protocol RouterToViewProtocol_Notes: AnyObject {
    func showAlert(alert: UIAlertController)
    func showModule(view: UIViewController)
}
