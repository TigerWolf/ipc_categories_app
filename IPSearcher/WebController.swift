import UIKit
import SVProgressHUD

class WebController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    //    var attributes: String = "" //Array<[String: Bool]> = []
    //    var data = [Hospital]()
    //    var airports = [String: Bool]()
    
    var ipc_code: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        //        NSLog("\(attributes)")
        //        self.title = "Patent Show"
        //        SVProgressHUD.show()
        //        getData()
        let url = NSURL(string: "http://pericles.ipaustralia.gov.au/ols/auspat/applicationDetails.do?applicationNo=" + self.ipc_code)
        //        let requestURL = NSURL(string:url)
        //        let request = NSURLRequest(URL: requestURL!)
        //        webView.loadHTMLString(url, baseURL: nil)
        //        let url = NSURL(string: "http://makeapppie.com")
        let requestObj = NSURLRequest(URL: url!)
        webView.delegate = self
        webView.loadRequest(requestObj)
    }
//    
//    override func webViewDidFinishLoad(webView: UIWebView){
//        SVProgressHUD.dismiss()
//    }
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        print("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
    return true;
    }
    
    func webViewDidStartLoad(webView: UIWebView!) {
        print("Webview started Loading")
    }
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        print("Webview did finish load")
        SVProgressHUD.dismiss()
    }
    
    
}