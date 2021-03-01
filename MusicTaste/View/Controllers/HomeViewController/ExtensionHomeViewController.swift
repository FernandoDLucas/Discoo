//
//  ExtensionHomeViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 12/02/21.
//

import UIKit
import CoreData

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfAlbuns
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.25)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCards.reuseIdentifier, for: indexPath) as? AlbumCards else {return AlbumCards()}
        let album = viewModel.albumForRow(at: indexPath)
        cell.configure(image: album.artwork!, artist: album.artist ?? "", year: album.year, name: album.name ?? "")
        cell.delegate = self
        cell.index = indexPath
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = viewModel.albumForRow(at: indexPath)
        if !editingState {self.navigationController?.pushViewController(AlbumDetailsViewController(album), animated: true)}
    }

}

extension HomeViewController {

    func configureNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Discoo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }

    @objc func add() {
        let controller = CreateAlbumViewController()
        let navControll = UINavigationController(rootViewController: controller)
        self.navigationController?.present(navControll, animated: true)
    }

    func setupCollectionView() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.invisibleView.bottomAnchor, constant: 30),
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    func setupInvisibleView() {
        self.view.addSubview(invisibleView)
        NSLayoutConstraint.activate([
            invisibleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            invisibleView.heightAnchor.constraint(equalToConstant: 1),
            invisibleView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            invisibleView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

   @objc func shakeItens() {
    editingState = true
    self.collectionView.visibleCells.forEach { (cell) in
        (cell as? AlbumCards)?.animate()
        }
    self.collectionView.backgroundView?.addGestureRecognizer(tapGesture)
   }

    @objc func finishShaking() {
        editingState = false
        self.collectionView.visibleCells.forEach { (cell) in
        (cell as? AlbumCards)?.stopAnimation()
        }
    }

    func displayAllert(album: Album) {
        let alert = UIAlertController(title: "Deletar \(album.name!)?",
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Deletar",
                                     style: .default) { _ in
            self.viewModel.deleteAlbum(album: album)
        self.editingState = false
        }
        let deleteAction = UIAlertAction(title: "Cancelar",
                                     style: .cancel)
        alert.addAction(okAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true)
    }
}

extension HomeViewController: DeleteCardDelegate {
    func didSelectDelete(at index: IndexPath) {
        let album = viewModel.albumForRow(at: index)
        self.displayAllert(album: album)
    }
}

extension HomeViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}
