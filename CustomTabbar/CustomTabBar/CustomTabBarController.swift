//
//  CustomTabBarController.swift
//  CustomTabbar
//
//  Created by Jatin on 23/07/25.
//

import UIKit

class CustomTabBarController: UIViewController, CustomTabBarDelegate {

    private let tabBarView = CustomTabBarView()
    private var currentViewController: UIViewController?
    var tabItems: [CustomTabItem] = [] {
        didSet {
            tabBarView.items = tabItems
            switchToTab(index: 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        view.addSubview(tabBarView)
        tabBarView.delegate = self
        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 83)
        ])
    }

    func didSelectTab(at index: Int) {
        switchToTab(index: index)
    }

    private func switchToTab(index: Int) {
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()

        let selectedVC = tabItems[index].viewController
        addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            selectedVC.view.bottomAnchor.constraint(equalTo: tabBarView.topAnchor),
            selectedVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectedVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        selectedVC.didMove(toParent: self)
        currentViewController = selectedVC
        tabBarView.selectedIndex = index
    }
}
