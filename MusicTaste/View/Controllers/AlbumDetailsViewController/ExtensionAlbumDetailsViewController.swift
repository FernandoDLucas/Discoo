//
//  ExtensionAlbumDetailsViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 17/02/21.
//

import UIKit
extension AlbumDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSongs
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let album = viewModel.songForRow(at: indexPath.row)
        var content = cell.defaultContentConfiguration()
        content.text = album.name
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.songForRow(at: indexPath.row)
        navigationController?.pushViewController(SongReviewController(song), animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextualAction = UIContextualAction(style: .destructive, title: "Deletar") {(_, _, completionHandler) in
            self.handleDelete(at: indexPath.row)
                    completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [contextualAction])
    }
}

extension AlbumDetailsViewController {
    func handleDelete(at index: Int) {
        viewModel.delete(at: index)
    }

    @objc func add(_ sender: UIBarButtonItem) {
          let alert = UIAlertController(title: "Adicionar música",
                                        message: "Adicione o nome da música",
                                        preferredStyle: .alert)
          let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
            guard let textField = alert.textFields?.first,
              let nameOfSong = textField.text else {
                return
            }
            self.viewModel.addSong(title: nameOfSong)
            self.viewModel.getAll()
          }
          let cancelAction = UIAlertAction(title: "Cancelar",
                                           style: .cancel)
          alert.addTextField()
          alert.addAction(saveAction)
          alert.addAction(cancelAction)
          present(alert, animated: true)
    }

    @objc func edit() {
         let album = viewModel.album
        navigationController?.pushViewController(EditAlbumViewController(with: album), animated: true)
    }
}
