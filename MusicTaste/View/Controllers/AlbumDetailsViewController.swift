//
//  AlbumDetailsViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class AlbumDetailsViewController : UIViewController{
    
    let viewModel : AlbumViewModel
    
    init(_ album: Album){
        self.viewModel = AlbumViewModel(album: album)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var tableView : UITableView = {
       let tv = UITableView(frame: .zero, style: .grouped)
       tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       return tv
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
        configureNavigation()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAll()
        print(viewModel.album)
    }
    
    private func configureNavigation() {
        self.title = viewModel.name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    @objc func add(_ sender: UIBarButtonItem){
          
          let alert = UIAlertController(title: "Add Song",
                                        message: "Add a new name",
                                        preferredStyle: .alert)
        
          let saveAction = UIAlertAction(title: "Save",
                                         style: .default) {
            [unowned self] action in
                                          
            guard let textField = alert.textFields?.first,
              let nameOfSong = textField.text else {
                return
            }
            viewModel.addSong(title: nameOfSong)
            viewModel.getAll()
          }
          
          let cancelAction = UIAlertAction(title: "Cancel",
                                           style: .cancel)
          
          alert.addTextField()
          
          alert.addAction(saveAction)
          alert.addAction(cancelAction)
          
          present(alert, animated: true)
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
    
}

extension AlbumDetailsViewController : UITableViewDelegate, UITableViewDataSource{
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
}

