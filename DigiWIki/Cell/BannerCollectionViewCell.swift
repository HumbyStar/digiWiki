//
//  BannerCollectionViewCell.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 29/11/22.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ivBanner: UIImageView!
    @IBOutlet weak var lbDigiSeries: UILabel!
    
    func prepare (with digiInfo: Info) {
        ivBanner.image = UIImage(named: digiInfo.name)
        lbDigiSeries.text = digiInfo.name
    }
    
}
