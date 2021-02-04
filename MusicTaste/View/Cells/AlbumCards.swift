//
//  AlbumCells.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class AlbumCards : UIView {
    
    var cover : UIImage?
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    func setupView(){
        self.addSubview(imageView)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
        ])
    }

}
