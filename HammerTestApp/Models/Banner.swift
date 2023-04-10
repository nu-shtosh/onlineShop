//
//  Banner.swift
//  HammerTestApp
//
//  Created by Илья Дубенский on 07.04.2023.
//

import Foundation

struct Banner {
    let name: String

    static func getDefaultBanners() -> [Banner] {
        [Banner(name: "bannerSale"), Banner(name: "bannerBDay")]
    }
}
