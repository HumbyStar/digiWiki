import UIKit




class DigiTableViewCell: UITableViewCell {

    @IBOutlet weak var lbLvl: UILabel!
    @IBOutlet weak var lbDigiName: UILabel!
    @IBOutlet weak var ivBits: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(_ digimon: Digimon) {
        lbLvl.text = digimon.age
        lbDigiName.text = digimon.name
        if let image = digimon.miniIMG as? UIImage {
            ivBits.image = image
        }
    }
    
    // imageview.layer.cornerRadius = imageview.layer.frame.size.width / 2
    // imageview.clipsToBounds = true
    // imageview.layer.bordercolor = UIColor.whitecolor().cgcolor
    // imageView.layer.borderwidth = 3
    
    // Make Corners rounded
    // imageview.layer.cornerRadius = 10
    // imageview.clipsToBounds = true
    // imageview.layer.borderColor = UIColor.whitecolor().cgcolor
    // imageview.layer.borderwidth = 3
    

}
