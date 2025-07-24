//
//  HomeViewController+Table.swift
//  CustomTabbar
//
//  Created by Jatin on 24/07/25.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = availableItems[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConfigTableItemCell.reuseIdentifier, for: indexPath) as? ConfigTableItemCell else {
            return UITableViewCell()
        }

        cell.configure(with: item)
        cell.checkmarkTapped = { [weak self] tappedCell in
            guard let self = self,
                  let tappedIndexPath = self.tableView.indexPath(for: tappedCell) else { return }

            self.availableItems[tappedIndexPath.row].isSelected.toggle()
            self.tableView.reloadRows(at: [tappedIndexPath], with: .automatic)
        }

        return cell
    }

    @objc private func toggleCheckmark(_ sender: UIButton) {
        let index = sender.tag
        availableItems[index].isSelected.toggle()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        availableItems[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = availableItems.remove(at: sourceIndexPath.row)
        availableItems.insert(movedItem, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
