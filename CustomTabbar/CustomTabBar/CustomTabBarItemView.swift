//
//  CustomTabBarItemView.swift
//  CustomTabbar
//
//  Created by Jatin on 23/07/25.
//

import UIKit

class CustomTabBarItemView: UIView {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let verticalStack = UIStackView()
    private let badgeLabel = UILabel()
    var tapHandler: (() -> Void)?

    var isSelected: Bool = false {
        didSet {
            iconImageView.tintColor = isSelected ? .systemBlue : .gray
            titleLabel.textColor = isSelected ? .systemBlue : .gray
        }
    }

    init(item: CustomTabItem) {
        super.init(frame: .zero)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        setupView(item: item)
        setupBadgeView()
        configureBadge(item.badgeConfig)
    }

    @objc private func handleTap() {
        tapHandler?()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView(item: CustomTabItem) {
        iconImageView.image = item.icon.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        titleLabel.text = item.title
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true

        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.spacing = 2
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.addArrangedSubview(iconImageView)
        verticalStack.addArrangedSubview(titleLabel)

        addSubview(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 4),
            verticalStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -4)
        ])
    }

    private func setupBadgeView() {
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.textAlignment = .center
        badgeLabel.textColor = .white
        badgeLabel.font = .systemFont(ofSize: 11)
        badgeLabel.backgroundColor = .red
        badgeLabel.layer.masksToBounds = true
        badgeLabel.isHidden = true

        addSubview(badgeLabel)

        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -4),
            badgeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -4),
            badgeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])
    }

    func configureBadge(_ config: BadgeConfig?) {
        guard let config = config else {
            badgeLabel.isHidden = true
            return
        }

        badgeLabel.isHidden = config.isHidden
        badgeLabel.backgroundColor = config.backgroundColor
        badgeLabel.textColor = config.textColor
        badgeLabel.font = config.font

        switch config.style {
        case .dot(let number):
            if let number = number {
                badgeLabel.text = "\(number)"
                badgeLabel.layer.cornerRadius = 9
                badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 18).isActive = true
            } else {
                badgeLabel.text = ""
                badgeLabel.layer.cornerRadius = 5
                badgeLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
                badgeLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
            }

        case .label(let text):
            badgeLabel.text = text
            badgeLabel.layer.cornerRadius = 8
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        }
    }
}
