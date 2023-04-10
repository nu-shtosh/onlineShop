//
//  MenuViewController.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MenuDisplayLogic: AnyObject {
    func displayMenu(viewModel: Menu.ShowItems.ViewModel)
}

class MenuViewController: UIViewController {
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemCell.self,
                           forCellReuseIdentifier: ItemCell.identifier)
        tableView.register(BannerTableViewCell.self,
                           forCellReuseIdentifier: BannerTableViewCell.identifier)
        tableView.register(CategoryCollectionTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CategoryCollectionTableViewHeader.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        return tableView
    }()

    var interactor: MenuBusinessLogic?
    var router: (NSObjectProtocol & MenuRoutingLogic & MenuDataPassing)?

    private var activityIndicator: UIActivityIndicatorView?
    private var rows: [ItemCellViewModelProtocol] = []
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuConfigurator.shared.configure(with: self)
        setupNavigationBar()
        setupMainView()
        addSubviews()
        setupConstraints()
        activityIndicator = showActivityIndicator(in: view)
        showItems()
    }

    private func showItems() {
        interactor?.fetchItems()
    }

    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }
}

// MARK: - Main View Setup
extension MenuViewController {
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()

        navBarAppearance.backgroundColor = .systemGray6
        let title = UIBarButtonItem(title: "Moscow")
        let image = UIBarButtonItem(title: "Moscow", image: UIImage(systemName: "chevron.down"), target: self, action: #selector(switchCity))
        navigationItem.leftBarButtonItems = [title, image]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .black
    }

    @objc func switchCity() {

    }
    private func setupMainView() {
        view.backgroundColor = .systemGray6
    }

    private func addSubviews() {
        view.addSubview(menuTableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return rows.count
        }
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return nil
        default:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryCollectionTableViewHeader.identifier)

            return headerView
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath)
            return cell
        default:
            let cellViewModel = rows[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath)
            guard let cell = cell as? ItemCell else { return UITableViewCell() }
            cell.viewModel = cellViewModel
            if indexPath.item == 0, indexPath.row == 0 {
                cell.layer.cornerRadius = 36
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 0
        default: return 50
        }
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            router?.routeToItemDetails(value: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 100
        default: return rows[indexPath.row].height
        }
    }

    func tableView(_ tableView: UITableView,
                    heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}

// MARK: - MenuDisplayLogic
extension MenuViewController: MenuDisplayLogic {
    func displayMenu(viewModel: Menu.ShowItems.ViewModel) {
        rows = viewModel.rows
        activityIndicator?.stopAnimating()
        menuTableView.reloadData()
    }
}
