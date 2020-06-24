//
//  TableViewCell.swift
//  Sample
//

import UIKit

//golbal
var imageCache:[String:UIImage] = [:]

class TableViewCell: UITableViewCell {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!

    var result:Results?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /*
     Declaration   loadData()
     
     Description   This method used to load data
     
     Declared In   MDActiveEnergy.swift
     */
    func loadData(){
        nameLabel.text = result?.name
        descLabel.text = result?.desc
        costLabel.text = String(result?.cost ?? Int(result?.costString ?? .staticCost) ?? 2000)
        if let image = imageCache[result?.url ?? ""]{
            images.image = image
        }else{
            guard let urlString = result?.url, let url = URL(string: urlString) else{
                return
            }
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: url) else{
                    return
                }
                DispatchQueue.main.async {
                    imageCache[urlString] = UIImage(data: data)
                    self.images.image = UIImage(data: data)
                }
            }
        }
    }
}


extension String{
    
    //url
    static let url = "https://digiapt-assets.s3.ap-south-1.amazonaws.com/assignments/products.json"
    
    //method
    static let get = "GET"
    
    //default string
    static let staticCost = "2000"
}
