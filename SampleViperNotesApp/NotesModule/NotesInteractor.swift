//
//  NotesInteractor.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/4/19.
//  Copyright © 2019 MES. All rights reserved.
//

import Foundation

class NotesInteractor: PresenterToInteractorProtocol_Notes {
    var presenter: InteractorToPresenterProtocol_Notes?
    
    func saveNote(note: Note) {
        var savedNotesIDs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_IDS) as? [Int] ?? []
        var savedNotesTitles = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_TITLES) as? [String] ?? []
        var savedNotesContents = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_CONTENTS) as? [String] ?? []
        var savedNotesFavs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_FAVS) as? [Bool] ?? []
        
        savedNotesIDs.append((savedNotesIDs.last ?? 0) + 1)
        savedNotesTitles.append(note.title)
        savedNotesContents.append(note.content)
        savedNotesFavs.append(note.isFavorite)
        
        UserDefaults.standard.set(savedNotesIDs, forKey: UserDefaultsKeys.NOTES_IDS)
        UserDefaults.standard.set(savedNotesTitles, forKey: UserDefaultsKeys.NOTES_TITLES)
        UserDefaults.standard.set(savedNotesContents, forKey: UserDefaultsKeys.NOTES_CONTENTS)
        UserDefaults.standard.set(savedNotesFavs, forKey: UserDefaultsKeys.NOTES_FAVS)
        
        fetchNotes()
    }
    
    func fetchNotes() {
        guard let ids = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_IDS) as? [Int], let titles = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_TITLES) as? [String], let contents = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_CONTENTS) as? [String], let favs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_FAVS) as? [Bool] else {
            presenter?.notesFetched(notes: [])
            
            return
        }
        
        var notes = [Note]()
        
        for (index, (title, content)) in zip(titles, contents).enumerated() {
            notes.append(Note(id: ids[index], title: title, content: content, isFavorite: favs[index]))
        }
        
        presenter?.notesFetched(notes: notes)
    }
    
    func fetchRandomTitle() {
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/posts/\(Int.random(in: 0..<100))")!) { (data, response, error) in
            guard let data = data else {
                self.presenter?.randomTitleFetchFailed()
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let title = json["title"] as? String {
                    self.presenter?.randomTitleFetched(title: title)
                } else {
                    self.presenter?.randomTitleFetchFailed()
                }
            } catch {
                print(error.localizedDescription)
                self.presenter?.randomTitleFetchFailed()
            }
        }.resume()
    }
    
    func deleteNote(id: Int) {
        var savedNotesIDs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_IDS) as? [Int] ?? []
        var savedNotesTitles = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_TITLES) as? [String] ?? []
        var savedNotesContents = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_CONTENTS) as? [String] ?? []
        var savedNotesFavs = UserDefaults.standard.array(forKey: UserDefaultsKeys.NOTES_FAVS) as? [Bool] ?? []
        
        guard let index = savedNotesIDs.firstIndex(where: { $0 == id }) else { return }
        
        savedNotesIDs.remove(at: index)
        savedNotesTitles.remove(at: index)
        savedNotesContents.remove(at: index)
        savedNotesFavs.remove(at: index)
        
        UserDefaults.standard.set(savedNotesIDs, forKey: UserDefaultsKeys.NOTES_IDS)
        UserDefaults.standard.set(savedNotesTitles, forKey: UserDefaultsKeys.NOTES_TITLES)
        UserDefaults.standard.set(savedNotesContents, forKey: UserDefaultsKeys.NOTES_CONTENTS)
        UserDefaults.standard.set(savedNotesFavs, forKey: UserDefaultsKeys.NOTES_FAVS)        
    }
}
