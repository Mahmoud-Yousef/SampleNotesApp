//
//  NotesPresenter.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 MES. All rights reserved.
//

import Foundation

class NotesPresenter: ViewToPresenterProtocol_Notes {
    
    weak var view: PresenterToViewProtocol_Notes?
    var interactor: PresenterToInteractorProtocol_Notes?
    var router: PresenterToRouterProtocol_Notes?
    private var notes = [Note]()
    
    func addNote() {
        router?.newNoteAlert(id: (notes.last?.id ?? 0) + 1, completion: { [unowned self] (note) in
            self.interactor?.saveNote(note: note)
        }, randomHandler: { [unowned self] in
            self.interactor?.fetchRandomTitle()
        })
    }
    
    func loadNotes() {
        interactor?.fetchNotes()
    }
    
    func showNoteDetails(selectedNote: Note) {
        router?.routeToNoteDetails(selectedNote: selectedNote)
    }
    
    func removeNote(id: Int) {
        interactor?.deleteNote(id: id)
    }
}

extension NotesPresenter: InteractorToPresenterProtocol_Notes {
    func notesFetched(notes: [Note]) {
        self.notes = notes
        view?.viewNotes(notes: notes)
    }
    
    func randomTitleFetched(title: String) {
        let note = Note(id: (notes.last?.id ?? 0) + 1, title: title, content: "", isFavorite: false)
        interactor?.saveNote(note: note)
    }
    
    func randomTitleFetchFailed() {
        view?.showAlert(message: "Failed to fetch title")
    }
}
