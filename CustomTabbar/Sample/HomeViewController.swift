//
//  HomeViewController.swift
//  CustomTabbar
//
//  Created by Jatin on 23/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    weak var tabController: CustomTabBarController?
    var tableView = UITableView()
    private var saveButton = UIButton(type: .system)

    let homeVC = PlaceholderViewController(title: "Home")
    let settingsVC = PlaceholderViewController(title: "Settings")
    let profileVC = PlaceholderViewController(title: "Profile")
    let searchVC = PlaceholderViewController(title: "Search")
    let chatVC = PlaceholderViewController(title: "Chat")
    let cameraVC = PlaceholderViewController(title: "Camera")
    let musicVC = PlaceholderViewController(title: "Music")
    let walletVC = PlaceholderViewController(title: "Wallet")
    let notificationsVC = PlaceholderViewController(title: "Notifications")
    let calendarVC = PlaceholderViewController(title: "Calendar")
    let mapVC = PlaceholderViewController(title: "Map")
    let filesVC = PlaceholderViewController(title: "Files")
    let photosVC = PlaceholderViewController(title: "Photos")
    let notesVC = PlaceholderViewController(title: "Notes")
    let settings2VC = PlaceholderViewController(title: "Advanced")

    var availableItems: [SelectableTabItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom tab bar demo"
        view.backgroundColor = .white
        tableView.isEditing = true
        setupTable()
        setupButton()
    }

    private func setupTable() {
        availableItems = [
            SelectableTabItem(title: "Home", icon: UIImage(systemName: "house")!, isSelected: true, viewController: self),
            SelectableTabItem(title: "Settings", icon: UIImage(systemName: "gear")!, isSelected: true, viewController: settingsVC),
            SelectableTabItem(title: "Profile", icon: UIImage(systemName: "person")!, isSelected: true, viewController: profileVC),
            SelectableTabItem(title: "Search", icon: UIImage(systemName: "magnifyingglass")!, isSelected: false, viewController: searchVC),
            SelectableTabItem(title: "Chat", icon: UIImage(systemName: "message")!, isSelected: false, viewController: chatVC),
            SelectableTabItem(title: "Camera", icon: UIImage(systemName: "camera")!, isSelected: false, viewController: cameraVC),
            SelectableTabItem(title: "Music", icon: UIImage(systemName: "music.note")!, isSelected: false, viewController: musicVC),
            SelectableTabItem(title: "Wallet", icon: UIImage(systemName: "creditcard")!, isSelected: false, viewController: walletVC),
            SelectableTabItem(title: "Notifications", icon: UIImage(systemName: "bell")!, isSelected: false, viewController: notificationsVC),
            SelectableTabItem(title: "Calendar", icon: UIImage(systemName: "calendar")!, isSelected: false, viewController: calendarVC),
            SelectableTabItem(title: "Map", icon: UIImage(systemName: "map")!, isSelected: false, viewController: mapVC),
            SelectableTabItem(title: "Files", icon: UIImage(systemName: "folder")!, isSelected: false, viewController: filesVC),
            SelectableTabItem(title: "Photos", icon: UIImage(systemName: "photo")!, isSelected: false, viewController: photosVC),
            SelectableTabItem(title: "Notes", icon: UIImage(systemName: "note.text")!, isSelected: false, viewController: notesVC),
            SelectableTabItem(title: "Advanced", icon: UIImage(systemName: "slider.horizontal.3")!, isSelected: false, viewController: settings2VC)
        ]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConfigTableItemCell.self, forCellReuseIdentifier: ConfigTableItemCell.reuseIdentifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }

    private func setupButton() {
        saveButton.setTitle("Save Tab Items", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.addTarget(self, action: #selector(saveTabBarItems), for: .touchUpInside)

        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func saveTabBarItems() {
        let selectedItems = availableItems.filter { $0.isSelected }

        guard selectedItems.count >= 2 && selectedItems.count <= 15 else {
            let alert = UIAlertController(title: "Invalid", message: "Select between 2 to 7 items.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        guard let tabController = self.tabController else { return }

        let _selectedItems = availableItems.filter { $0.isSelected }

        UIView.transition(with: tabController.view, duration: 0.3, options: .transitionCrossDissolve) {
            tabController.tabItems = _selectedItems.map {
                CustomTabItem(title: $0.title, icon: $0.icon, viewController: $0.viewController, badgeConfig: Bool.random() ? (Bool.random() ? .labelStyle(text: "Hi") : (Bool.random() ? .dotStyle() : .dotStyle(number: Int.random(in: 1...10))) ) : nil)
            }
        }
    }
}


