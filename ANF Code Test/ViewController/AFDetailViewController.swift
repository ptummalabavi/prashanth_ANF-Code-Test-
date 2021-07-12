import UIKit
import WebKit
import SDWebImage

class AFDetailViewController: UIViewController {
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var viewTopDesc:UIView!
    @IBOutlet weak var lblTopDesc:UILabel!
    @IBOutlet weak var viewTitle:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var viewPromo:UIView!
    @IBOutlet weak var lblPromo:UILabel!
    @IBOutlet weak var viewWebView:UIView!
    @IBOutlet weak var webview:WKWebView!
    @IBOutlet weak var webViewHeight:NSLayoutConstraint!
    @IBOutlet weak var viewContenList:UIView!
    @IBOutlet weak var tblContentList:UITableView!
    @IBOutlet weak var tblContentListHeight:NSLayoutConstraint!
    
    
    var afDetail: AFDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
    }
    
    
    ///set UI and register tableview cell
    private func setupUI() {
        webview.navigationDelegate = self
        tblContentList.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        tblContentList.reloadData()
    }
    
    ///bind data with views
    private func setData() {
        imgView.sd_setImage(with: URL(string: afDetail.backgroundImage ?? ""), completed: nil)
        lblTopDesc.text = afDetail.topDescription
        viewTopDesc.isHidden = afDetail.isTopDescAvailable
        lblTitle.text = afDetail.title
        viewTitle.isHidden = afDetail.isTitleAvailable
        self.title = afDetail.topDescription
        lblPromo.text = afDetail.promoMessage
        viewPromo.isHidden = afDetail.isPromoAvailable
        tblContentListHeight.constant = CGFloat((afDetail.content?.count ?? 0) * 50)
        tblContentList.reloadData()
        viewContenList.isHidden = afDetail.isContentAvailable
        loadHTMLContent(afDetail.bottomDescription ?? "")
        viewWebView.isHidden = afDetail.isBottomDescAvailable
    }
    
    /// load content in webview
    func loadHTMLContent(_ htmlContent: String) {
        let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
        let htmlEnd = "</BODY></HTML>"
        let htmlString = "\(htmlStart)\(htmlContent)\(htmlEnd)"
        webview.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
    
}

/// UITablew Datasource and DataDelegate methods
extension AFDetailViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return afDetail.content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as? ContentTableViewCell,
              let objModel = afDetail.content?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.confireCell(objModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contents = afDetail.content, contents.count > indexPath.row else {
            return
        }
        
        let objModel = contents[indexPath.row]
        
        guard let urlString = objModel.target, let openURL = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
    }
}
///WKNavigationDelegate method
extension AFDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
            guard let heightConstant = height as? CGFloat else {
                return
            }
            self.webViewHeight?.constant = heightConstant
        })
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        switch navigationAction.navigationType {
        case .linkActivated:
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            }
            else {
                // Fallback on earlier versions
                UIApplication.shared.canOpenURL(navigationAction.request.url!)
            }
            decisionHandler(.cancel)
            return
        default:
            break
        }
        decisionHandler(.allow)
    }
}

