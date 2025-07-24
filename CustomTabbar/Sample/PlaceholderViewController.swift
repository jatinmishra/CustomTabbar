//
//  PlaceholderViewController.swift
//  CustomTabbar
//
//  Created by Jatin on 23/07/25.
//

import UIKit

class PlaceholderViewController: UIViewController {

    private let titleText: String

    init(title: String) {
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
        self.title = title  // sets the VC’s navigation/tab title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = titleText
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .label

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
