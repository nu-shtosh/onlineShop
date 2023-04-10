//
//  ItemDetailsConfigurator.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 04.04.2023.
//

import Foundation

final class ItemDetailsConfigurator {
    static let shared: ItemDetailsConfigurator = .init()

    func configure(with viewController: ItemDetailsViewController) {
        let interactor = ItemDetailsInteractor()
        let presenter = ItemDetailsPresenter()
        let router = ItemDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
