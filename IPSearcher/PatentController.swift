import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PatentController: UITableViewController {
    
    @IBOutlet weak var webView: UIWebView!
//    var attributes: String = "" //Array<[String: Bool]> = []
    var data = [Hospital]()
    //    var airports = [String: Bool]()
    
    var ipc_code: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        //
        data.append(Hospital(location_name: "Patent 1", location_id: "a"))
        data.append(Hospital(location_name: "Patent 2", location_id: "a"))
        data.append(Hospital(location_name: "Patent 3", location_id: "a"))
        data.append(Hospital(location_name: "Patent 4", location_id: "a"))
        data.append(Hospital(location_name: "Patent 5", location_id: "a"))
        data.append(Hospital(location_name: "Patent 6", location_id: "a"))
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var key = data[indexPath.row]
        self.tap(key)
    }
    
    func tap(key: Hospital){
        let storyboard = UIStoryboard(name: "Patent", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("webviewController") as! WebController

        self.navigationController!.pushViewController(vc, animated:true)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var hospital = data[indexPath.row] //as! Hospital
        var cell_ : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("HospitalCell") as? UITableViewCell
        if(cell_ == nil)
        {
            cell_ = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "HospitalCell")
        }
        cell_!.textLabel!.text = hospital.location_name //"aa" //TitleCase(name!) //hospital as String? //hospital.location_name\
        return cell_!
    }
    




}