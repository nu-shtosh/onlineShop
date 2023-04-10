//
//  CategoryCell.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 06.04.2023.
//

import UIKit

class CategoryCollectionTableViewHeader: UITableViewHeaderFooterView {

    // MARK: - Identifier

    static let identifier = "CategoriesHeader"

    // MARK: - Private Properties
    
    private let categories = Category.allCases

    lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 50)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Main View Setup
extension CategoryCollectionTableViewHeader {
    private func setupView() {
        contentView.backgroundColor = .systemGray6
    }

    private func addSubviews() {
        contentView.addSubview(categoriesCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate And UICollectionViewDataSource
extension CategoryCollectionTableViewHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier,
                                                      for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.item]
        cell.updateView(with: category)
        return cell
    }
}
