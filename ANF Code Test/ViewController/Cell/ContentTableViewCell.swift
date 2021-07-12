import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnContent:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnContent.layer.borderColor =  UIColor.darkGray.cgColor
        btnContent.layer.borderWidth =  1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //configuur cell with content detail
    func confireCell(_ objModel:ContentDetailModel) {
        
        if let name = objModel.title {
            btnContent.setTitle(name, for: .normal)
            
            let target = objModel.target?.isEmpty ?? false
            btnContent.setTitleColor(target ? .darkGray : .link , for: .normal)
        }
        
    }
    
}
