//
//  ItemCell.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 04.04.2023.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: ItemCellViewModelProtocol? { get }
}

class ItemCell: UITableViewCell, CellModelRepresentable {

    static let identifier = "ItemCell"

    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()

    private lazy var itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 8)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var itemPriceButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setTitleColor(UIColor(named: "customRed"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "customRed")?.cgColor
        button.layer.cornerRadius = 8
        return button
    }()

    var viewModel: ItemCellViewModelProtocol? {
        didSet {
            backgroundColor = .white
            addSubviews()
            setupConstraints()
            activityIndicatorView.startAnimating()
            updateView()
        }
    }

    private func updateView() {
        guard let viewModel = viewModel as? ItemCellViewModel else { return }
        ImageManager.shared.fetchImage(from: viewModel.itemImageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.itemImageView.image = UIImage(data: imageData)
                self?.activityIndicatorView.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        itemTitleLabel.text = viewModel.itemName
        itemDescriptionLabel.text = viewModel.itemDescription
        itemPriceButton.setTitle("от \(viewModel.itemPrice)$", for: .normal)
    }

    private func addSubviews() {
        addSubview(itemImageView)
        itemImageView.addSubview(activityIndicatorView)
        addSubview(itemTitleLabel)
        addSubview(itemDescriptionLabel)
        addSubview(itemPriceButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            itemImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemImageView.heightAnchor.constraint(equalToConstant: 100),

            activityIndicatorView.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),

            itemTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            itemTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            itemDescriptionLabel.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 6),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            itemPriceButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            itemPriceButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            itemPriceButton.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
}
