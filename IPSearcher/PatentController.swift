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
        data.append(Hospital(location_name: "2011288044 - Use of Salvia miltiorrhiza composition in preparing drugs for secondary prevention of coronary heart disease", location_id: "2011288044"))
        data.append(Hospital(location_name: "2012286557 - Solid and liquid separation process", location_id: "2012286557"))
        data.append(Hospital(location_name: "2009253727 - Binding particulate materials to manufacture articles", location_id: "2009253727"))
        data.append(Hospital(location_name: "2010221783 - Rotary blood pump", location_id: "2010221783"))
        data.append(Hospital(location_name: "2003100345 - Impact cushioning device", location_id: "2003100345"))
        data.append(Hospital(location_name: "2008315932 - Method for producing stainless steel using direct reduction furnaces for ferrochrome and ferronickel on the primary side of a converter", location_id: "2008315932"))
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
        vc.ipc_code = key.location_id
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