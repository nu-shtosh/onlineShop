//
//  BannersTableViewCell.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 07.04.2023.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    // MARK: - Identifier
    static let identifier = "BannerTableViewCell"

    // MARK: - Private Properties
    private lazy var banners = Banner.getDefaultBanners()

    // MARK: - UI Elements
    private lazy var bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 280, height: 100)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BannerCollectionViewCell.self,
                                forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Setup View
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        addSubviews()
        setupConstraints()
    }
}

// MARK: - Main View Setup
extension BannerTableViewCell {
    private func setupView() {
        contentView.backgroundColor = .systemGray6
    }

    private func addSubviews() {
        contentView.addSubview(bannersCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannersCollectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            bannersCollectionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            bannersCollectionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            bannersCollectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate And UICollectionViewDataSource
extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        banners.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier,
                                                      for: indexPath) as! BannerCollectionViewCell
        let banner = banners[indexPath.item]
        cell.updateView(with: banner)
        return cell
    }
}
