//
//  EditAlbumViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 22/02/21.
//

import UIKit

class EditAlbumViewController: UIViewController {

    let imagePicker = UIImagePickerController()

    let viewModel: EditAlbumViewModel

    init(with album: Album) {
        self.viewModel = EditAlbumViewModel(with: album)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let pickerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addIconNew")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

     var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.imagePicker.delegate = self
        self.tableView.register(AlbumFieldsCell.self, forCellReuseIdentifier: AlbumFieldsCell.reuseIdentifier)
        self.viewModel.handleDismiss = {
            self.navigationController?.popViewController(animated: true)
        }
        configurateNavigationBar()
        setupPicker()
        setupTableView()
        configureData()
    }

    private func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.pickerView.bottomAnchor, constant: 17),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    func configurateNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .done, target: self,
                                                                action: #selector(attemptToSave))
   }

    @objc func attemptToSave() {
            viewModel.saveButton()
    }

    func configureData() {
        pickerView.image = UIImage(data: viewModel.album.artwork!)
    }
}

extension EditAlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: AlbumFieldsCell.reuseIdentifier, for: indexPath) as? AlbumFieldsCell else {
            return AlbumFieldsCell()
        }
        cell.delegate = viewModel
        cell.configureFieldName(fieldName: viewModel.fieldName(row: indexPath.row)!)
        cell.configureFieldValue(with: viewModel.fieldValue(row: indexPath.row))
        return cell
    }
}

extension EditAlbumViewController {

    func setupPicker() {
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        pickerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 17).isActive = true
        pickerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tootlePicker))
        pickerView.addGestureRecognizer(gesture)
    }

    @objc func tootlePicker() {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension EditAlbumViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let fixedImage = image.fixedOrientation
                pickerView.image = fixedImage
                if let data = fixedImage.pngData() {
                viewModel.getImage(data: data)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
