//
//  NoteDetailsPresenter.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/8/19.
//  Copyright © 2019 MES. All rights reserved.
//

import Foundation

class NoteDetailsPresenter: ViewToPresenterProtocol_NoteDetails {
    
    weak var view: PresenterToViewProtocol_NoteDetails?
    var interactor: PresenterToInteractorProtocol_NoteDetails?
    var router: PresenterToRouterProtocol_NoteDetails?
    var note: Note?
    
    func showNote() {
        guard let note = note else { return }
        view?.displayNote(title: note.title, content: note.content)
    }
    
    func editNote(title: String, content: String) {
        guard var note = note else { return }
        note.title = title
        note.content = content
        interactor?.saveNote(note: note)
    }
}

extension NoteDetailsPresenter: InteractorToPresenterProtocol_NoteDetails {
    
}
