//
//  CustomTabBarDelegate.swift
//  CustomTabbar
//
//  Created by Jatin on 23/07/25.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

class CustomTabBarView: UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var itemViews: [CustomTabBarItemView] = []
    weak var delegate: CustomTabBarDelegate?
    private var stackViewWidthConstraint: NSLayoutConstraint?

    var selectedIndex: Int = 0 {
        didSet {
            updateSelection()
        }
    }

    var items: [CustomTabItem] = [] {
        didSet {
            setupItemViews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        isUserInteractionEnabled = true
        backgroundColor = .systemBackground
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 4
        
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0

        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func setupItemViews() {
        itemViews.forEach { $0.removeFromSuperview() }
        itemViews = []

        let isScrollable = items.count > 7
        scrollView.isScrollEnabled = isScrollable
        // Clean up previous width constraint
        stackViewWidthConstraint?.isActive = false

        if isScrollable {
            scrollView.isScrollEnabled = true
            stackView.distribution = .fill
            stackViewWidthConstraint = nil  // no constraint needed
        } else {
            scrollView.isScrollEnabled = false
            stackView.distribution = .fillEqually
            // Constrain to scrollView width
            stackViewWidthConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            stackViewWidthConstraint?.isActive = true
        }

        for (index, item) in items.enumerated() {
            let itemView = CustomTabBarItemView(item: item)
            itemView.tag = index
            itemView.tapHandler = { [weak self] in
                self?.selectedIndex = index
                self?.delegate?.didSelectTab(at: index)
            }
            itemViews.append(itemView)
            stackView.addArrangedSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true

            if isScrollable {
                itemView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            }
        }

        updateSelection()
    }

    private func updateSelection() {
        for (index, view) in itemViews.enumerated() {
            view.isSelected = (index == selectedIndex)
        }
    }

    @objc private func tabTapped(_ gesture: UITapGestureRecognizer) {
        guard let index = gesture.view?.tag else { return }
        selectedIndex = index
        delegate?.didSelectTab(at: index)
    }
}
