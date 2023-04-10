//
//  BannerCollectionViewCell.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 07.04.2023.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    static let identifier = "BannerCollectionViewCell"

    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerCollectionViewCell {
    func updateView(with banner: Banner) {
        bannerImageView.image = UIImage(named: banner.name)
    }

    private func addSubviews() {
        contentView.addSubview(bannerImageView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
