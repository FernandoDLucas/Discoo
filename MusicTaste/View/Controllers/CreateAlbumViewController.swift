//
//  CreateAlbumViewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class CreateAlbumViewController: UIViewController {

    let imagePicker = UIImagePickerController()

    let viewModel = CreateAlbumViewModel()

    public var callBack : (() -> Void)?

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
            self.dismiss(animated: true, completion: nil)
            self.callBack?()
        }
        configurateNavigationBar()
        setupPicker()
        setupTableView()
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
       self.title = "Novo Album"
       self.isModalInPresentation = true

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .done, target: self.viewModel,
                                                                action: #selector(viewModel.cancelButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .done, target: self,
                                                                action: #selector(attemptToSave))
   }

    @objc func attemptToSave() {
        if viewModel.albumDTO.artwork == nil {
              let alert = UIAlertController(title: "Adicione a imagem",
                                            message: "Adicione ao menos a capa do álbum para que ele seja salvo",
                                            preferredStyle: .alert)
              let okAction = UIAlertAction(title: "Ok",
                                           style: .default)
              alert.addAction(okAction)
            self.present(alert, animated: true)
        } else {
            viewModel.saveButton()
        }
    }
}

extension CreateAlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: AlbumFieldsCell.reuseIdentifier, for: indexPath) as? AlbumFieldsCell else {
            return AlbumFieldsCell()
        }
        cell.delegate = viewModel
        cell.configure(fieldName: viewModel.fieldName(row: indexPath.row)!)
        return cell
    }
}

extension CreateAlbumViewController {

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

extension CreateAlbumViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
