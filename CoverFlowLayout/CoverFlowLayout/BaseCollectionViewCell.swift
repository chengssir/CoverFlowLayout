//
//  BaseCollectionViewCell.swift
//  SwiftScrollBanner
//
//  Created by xcode on 2024/11/8.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    private var textLabel: UILabel!
    
    let contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cellIndex: Int = 0 {
        didSet {
            textLabel.text = "ASD"
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(contentContainer)
        contentContainer.layer.masksToBounds = true
        contentContainer.layer.cornerRadius = 35
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            contentContainer.heightAnchor.constraint(equalToConstant: 70),  // 固定高度为 60
            contentContainer.widthAnchor.constraint(equalToConstant: 70),  // 固定高度为 60
            contentContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),  // 垂直居中
        ])
                
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false  // 关闭自动缩放转换
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -4),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 17),  // 固定高度为 60
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let customAttributes = layoutAttributes as? CustomLayoutAttributes {
              let scale = customAttributes.scale
              contentContainer.transform = CGAffineTransform(scaleX: scale, y: scale)
          }
    }
}
