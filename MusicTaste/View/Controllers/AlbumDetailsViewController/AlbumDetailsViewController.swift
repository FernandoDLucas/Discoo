//
//  AlbumDetailsViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    let viewModel: AlbumViewModel

    init(_ album: Album) {
        self.viewModel = AlbumViewModel(album: album)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .systemBackground
       return tableView
   }()

    let newSongButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Adicionar Música"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .systemBackground
        viewModel.handleUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        setupTableView()
        setupNewSongButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAll()
        configureNavigation()
    }

    private func configureNavigation() {
        self.title = viewModel.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .done, target: self, action: #selector(edit))
    }

    private func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    private func setupNewSongButton() {
        self.view.addSubview(newSongButton)
        newSongButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        NSLayoutConstraint.activate([
            newSongButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            newSongButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17)
        ])
    }
}
