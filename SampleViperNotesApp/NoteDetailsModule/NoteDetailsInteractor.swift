//
//  NoteDetailsInteractor.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/8/19.
//  Copyright © 2019 MES. All rights reserved.
//

import Foundation

class NoteDetailsInteractor: PresenterToInteractorProtocol_NoteDetails {
    var presenter: InteractorToPresenterProtocol_NoteDetails?
    
    func saveNote(note: Note) {
        let savedNotesIDs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_IDS) as? [Int] ?? []
        var savedNotesTitles = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_TITLES) as? [String] ?? []
        var savedNotesContents = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_CONTENTS) as? [String] ?? []
        let savedNotesFavs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_FAVS) as? [Bool] ?? []
        
        guard let index = savedNotesIDs.firstIndex(where: { $0 == note.id }) else { return }
        
        savedNotesTitles[index] = note.title
        savedNotesContents[index] = note.content
        
        UserDefaults.standard.set(savedNotesIDs, forKey: UserDefaultsKeys.NOTES_IDS)
        UserDefaults.standard.set(savedNotesTitles, forKey: UserDefaultsKeys.NOTES_TITLES)
        UserDefaults.standard.set(savedNotesContents, forKey: UserDefaultsKeys.NOTES_CONTENTS)
        UserDefaults.standard.set(savedNotesFavs, forKey: UserDefaultsKeys.NOTES_FAVS)
    }
}
