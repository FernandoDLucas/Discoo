//
//  SongReviewController.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class SongReviewController : UIViewController{
    
    let viewModel : SongViewModel
        
    init(_ song: Song){
        self.viewModel = SongViewModel(song)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var textField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .justified
        tf.textAlignment = .left
        tf.contentVerticalAlignment = .top
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = viewModel.song.name
        self.textField.delegate = self
        configTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !textField.hasText {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.textField.becomeFirstResponder()
        }
    }
    }
    
    func configTextField(){
        self.view.addSubview(textField)
        self.textField.text = viewModel.song.review
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 17),
            textField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            textField.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}

extension SongReviewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.didUpdateTextField(txt: textField.text!)
    }

}

