//
//  HomeViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class HomeViewController: UIViewController {

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AlbumCards.self, forCellWithReuseIdentifier: AlbumCards.reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let viewModel = AlbumListViewModel()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.handleUpdate = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        configureNavigation()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAll()
    }

    private func configureNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Disco"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }

    @objc func add() {
        let controller = CreateAlbumViewController()
        controller.callBack = {
            self.viewModel.getAll()
             self.viewModel.handleUpdate?()
        }
        let navControll = UINavigationController(rootViewController: controller)
        self.navigationController?.present(navControll, animated: true)
    }

    func setupCollectionView() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 17),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfAlbuns
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.height * 0.22)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width * 0.14, bottom: UIScreen.main.bounds.height * 0.8, right: UIScreen.main.bounds.width * 0.14)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCards.reuseIdentifier, for: indexPath) as? AlbumCards else {return AlbumCards()}
        guard let album = viewModel.albumForRow(at: indexPath.row) else {return AlbumCards()}
        cell.configure(image: album.artwork!, artist: album.artist ?? "", year: album.year, name: album.name ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album = viewModel.albumForRow(at: indexPath.row)?.album else {return}
        self.navigationController?.pushViewController(AlbumDetailsViewController(album), animated: true)
    }
}
