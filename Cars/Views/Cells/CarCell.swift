//
//  CarTableViewCell.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 22/03/2022.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

class CarCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var ivCar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    // MARK: - Properties
    public static let identifier = "carCell"
    
    private let gradientMaskLayer = CAGradientLayer()
    private let activityIndicatorView = NVActivityIndicatorView(frame: CGRect())
    
    var mCar: CarPlainModel? {
        didSet{
            guard let data = mCar else { return }
            lblTitle?.text = data.title
            lblDesc.text = data.desc
 
            let imgPlaceholder = UIImage(named: "placeholder.png")
            let indicator = loadingIndicator()
            let imagePath = AppConstants.PokemonImagePath + data.title.lowercased() + ".jpg"
            ivCar.kf.setImage(with: URL(string:imagePath),
                              placeholder: imgPlaceholder,
                              options: [.transition(.fade(0.4))]) { (url) in
                indicator.stopAnimating()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupGradientView()
    }
    
    private func setupGradientView() {
        self.viewContent.backgroundColor = .black
        gradientMaskLayer.colors = [ UIColor.clear.cgColor,
                                     UIColor.black.withAlphaComponent(0.85).cgColor,
                                     UIColor.black.cgColor,
                                     UIColor.black.cgColor]
        self.viewContent.layer.mask = gradientMaskLayer
        self.lblTitle.textColor = .white
        self.lblDesc.textColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientMaskLayer.frame = viewContent.bounds
        let center = CGPoint(x: ivCar.center.x, y: ivCar.center.y - 34)
        activityIndicatorView.center = center
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //to correct the cell's height (1st time loading)
        layoutIfNeeded()
    }
    
    func loadingIndicator() -> NVActivityIndicatorView {
        activityIndicatorView.frame.size = CGSize(width: 34, height: 34)
        activityIndicatorView.type = NVActivityIndicatorType.ballClipRotateMultiple
        ivCar.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
}
