//
//  BadgeConfig.swift
//  CustomTabbar
//
//  Created by Jatin on 24/07/25.
//

import UIKit

struct BadgeConfig {
    var style: BadgeStyle
    var backgroundColor: UIColor
    var textColor: UIColor
    var font: UIFont
    var isHidden: Bool = false

    static func dotStyle(number: Int? = nil) -> BadgeConfig {
        BadgeConfig(
            style: .dot(number: number),
            backgroundColor: .red,
            textColor: .white,
            font: .systemFont(ofSize: 12)
        )
    }

    static func labelStyle(text: String) -> BadgeConfig {
        BadgeConfig(
            style: .label(text: text),
            backgroundColor: .systemBlue,
            textColor: .white,
            font: .systemFont(ofSize: 11, weight: .medium)
        )
    }
}
