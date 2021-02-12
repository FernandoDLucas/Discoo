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
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    lazy var longPressedGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(shakeItens))
        gesture.minimumPressDuration = 1
        return gesture
    }()

    lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(finishShaking))
        return gesture
    }()

    var editingState: Bool = false

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
        self.view.addGestureRecognizer(longPressedGesture)
    }
}
