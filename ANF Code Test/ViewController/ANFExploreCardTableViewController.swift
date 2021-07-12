//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import SDWebImage

class ANFExploreCardTableViewController: UITableViewController {
    
    var exploreDataList:[AFDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ANF"
        getExploreData()
        NotificationCenter.default.addObserver(self, selector: #selector(getExploreData), name: UIApplication.willEnterForegroundNotification
                    , object: nil)
    }
    
    @objc func getExploreData() {
        AFDetailsViewModel().getAFDetails { (results) in
            self.exploreDataList = results ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "exploreContentCell", for: indexPath)
        if let titleLabel = cell.viewWithTag(1) as? UILabel,
           let titleText = exploreDataList[indexPath.row].title {
            titleLabel.text = titleText
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView,
           let name = exploreDataList[indexPath.row].backgroundImage {
            imageView.sd_setImage(with: URL(string: name), completed: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if exploreDataList.count > indexPath.row,
           let objVC = self.storyboard?.instantiateViewController(identifier: "AFDetailViewController") as? AFDetailViewController {
            objVC.afDetail = exploreDataList[indexPath.row]
            self.navigationController?.pushViewController(objVC, animated: true)
        }
    }
}
