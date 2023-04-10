//
//  TabBarController.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 03.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
    }

    private func setupTabBar() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = UIColor(named: "customRed")
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func setupItems() {
        let menuVC = MenuViewController()
        let contactsVC = ContactsViewController()
        let profileVC = ProfileViewController()
        let cartVC = CartViewController()

        let menuNavBarVC = UINavigationController(rootViewController: menuVC)

        setViewControllers([menuNavBarVC, contactsVC, profileVC, cartVC],
                           animated: true)

        guard let items = tabBar.items else { return }

        items[0].title = "Shop"
        items[1].title = "Contacts"
        items[2].title = "Profile"
        items[3].title = "Cart"

        items[0].image = UIImage(systemName: "menucard")
        items[1].image = UIImage(systemName: "phone.down")
        items[2].image = UIImage(systemName: "person")
        items[3].image = UIImage(systemName: "cart")
    }

}
