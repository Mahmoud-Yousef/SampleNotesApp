//
//  NoteDetailsRouter.swift
//  SampleViperNotesApp
//
//  Created by mac on 12/8/19.
//  Copyright © 2019 MES. All rights reserved.
//

import UIKit

class NoteDetailsRouter: PresenterToRouterProtocol_NoteDetails {
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    static func createNoteDetailsModule(selectedNote: Note) -> UIViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: StoryboardViewIDs.NOTE_DETAILS_VIEW_CONTROLLER) as! NoteDetailsViewController
        
        let presenter = NoteDetailsPresenter()
        let interactor: PresenterToInteractorProtocol_NoteDetails = NoteDetailsInteractor()
        let router: PresenterToRouterProtocol_NoteDetails = NoteDetailsRouter()
        
        view.presenter = presenter as ViewToPresenterProtocol_NoteDetails
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter as InteractorToPresenterProtocol_NoteDetails
        presenter.note = selectedNote
        
        return view
    }
}
