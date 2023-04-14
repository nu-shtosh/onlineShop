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

    let categories = Category.allCases

    private lazy var categoriesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width + 280,
            height: .zero
        )
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    lazy var categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
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

    func selectButton(button: UIButton) {
        guard let buttons = categoriesStackView.arrangedSubviews as? [UIButton] else { return }
        for button in buttons {
            setNormal(button: button)
        }
        setSelected(button: button)
    }

    func setSelected(button: UIButton) {
        button.backgroundColor = UIColor(named: "customPink")
    }

    func setNormal(button: UIButton) {
        button.backgroundColor = .clear
    }
}

// MARK: - Main View Setup
extension CategoryCollectionTableViewHeader {
    private func setupView() {
        contentView.backgroundColor = .systemGray6
    }

    private func addSubviews() {
        addSubview(categoriesScrollView)
        categoriesScrollView.addSubview(categoriesStackView)
        addButtons()
    }

    private func addButtons() {
        for category in Category.allCases {
            let button = UIButton(type: .roundedRect)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitleColor(UIColor(named: "customRed"), for: .normal)
            button.contentScaleFactor = .leastNormalMagnitude
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(named: "customRed")?.cgColor
            button.layer.cornerRadius = 12
            button.setTitle(category.rawValue.capitalized, for: .normal)
            button.widthAnchor.constraint(equalToConstant: 120).isActive = true
            categoriesStackView.addArrangedSubview(button)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoriesScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            categoriesScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            categoriesScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            categoriesScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            categoriesStackView.leadingAnchor.constraint(equalTo: categoriesScrollView.leadingAnchor, constant: 16),
            categoriesStackView.trailingAnchor.constraint(equalTo: categoriesScrollView.trailingAnchor, constant: -16),
            categoriesStackView.centerYAnchor.constraint(equalTo: categoriesScrollView.centerYAnchor)
        ])
    }
}
