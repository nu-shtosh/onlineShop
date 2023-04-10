//
//  CategoryCollectionViewCell.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 07.04.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "CategoryCell"

    var category: Category?

    private lazy var categoryButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor(named: "customRed"), for: .normal)
        button.contentScaleFactor = .leastNormalMagnitude
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "customRed")?.cgColor
        button.layer.cornerRadius = 18
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCell {
    func updateView(with category: Category) {
        categoryButton.setTitle(category.rawValue.capitalized, for: .normal)
    }

    private func addSubviews() {
        contentView.addSubview(categoryButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            categoryButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}
