//
//  ConfigTableItemCell.swift
//  CustomTabbar
//
//  Created by Jatin on 23/07/25.
//

import UIKit

class ConfigTableItemCell: UITableViewCell {

    static let reuseIdentifier = "ConfigTableItemCell"

    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let checkmarkButton = UIButton(type: .system)

    var checkmarkTapped: ((ConfigTableItemCell) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = .label

        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        checkmarkButton.addTarget(self, action: #selector(checkmarkPressed), for: .touchUpInside)

        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkButton)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: checkmarkButton.leadingAnchor, constant: -12),

            checkmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 30),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 30),
        ])

        showsReorderControl = true
    }

    func configure(with item: SelectableTabItem) {
        titleLabel.text = item.title
        iconImageView.image = item.icon

        let imageName = item.isSelected ? "checkmark.circle.fill" : "circle"
        let color: UIColor = item.isSelected ? .systemBlue : .lightGray
        checkmarkButton.setImage(UIImage(systemName: imageName), for: .normal)
        checkmarkButton.tintColor = color
    }

    @objc private func checkmarkPressed() {
        checkmarkTapped?(self)
    }
}
