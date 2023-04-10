//
//  ContactsPresenter.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol ContactsPresentationLogic {
    func presentSomething(response: Contacts.Something.Response)
}

class ContactsPresenter: ContactsPresentationLogic {
    
    weak var viewController: ContactsDisplayLogic?
    
    func presentSomething(response: Contacts.Something.Response) {
        let viewModel = Contacts.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
