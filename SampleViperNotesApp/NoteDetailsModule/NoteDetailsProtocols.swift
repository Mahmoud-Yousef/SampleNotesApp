//
//  NoteDetailsProtocols.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/8/19.
//  Copyright © 2019 MES. All rights reserved.
//

import UIKit

protocol PresenterToViewProtocol_NoteDetails: AnyObject {
    func displayNote(title: String, content: String)
}

protocol ViewToPresenterProtocol_NoteDetails: AnyObject {
    var view: PresenterToViewProtocol_NoteDetails? { get set }
    var interactor: PresenterToInteractorProtocol_NoteDetails? { get set }
    var router: PresenterToRouterProtocol_NoteDetails? { get set }
    
    func showNote()
    func editNote(title: String, content: String)
}

protocol PresenterToInteractorProtocol_NoteDetails: AnyObject {
    var presenter: InteractorToPresenterProtocol_NoteDetails? { get set }
    
    func saveNote(note: Note)
}

protocol InteractorToPresenterProtocol_NoteDetails: AnyObject {
    
}

protocol PresenterToRouterProtocol_NoteDetails: AnyObject {
    static func createNoteDetailsModule(selectedNote: Note) -> UIViewController
}
