//
//  ViewController.swift
//  Hospitals
//
//  Created by a1673450 on 30/06/2015.
//  Copyright (c) 2015 Kieran. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ServicesController: UITableViewController {
    
    var attributes: String = "" //Array<[String: Bool]> = []
    var data = [Hospital]()
//    var airports = [String: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("\(attributes)")
        self.title = attributes + " Patents"
        SVProgressHUD.show()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func getData(){
//        var url = "http://localhost:3000/"
        var url = "http://digitalhub.unleashingsa.com.au/"
        var path = "api/v1/categories/children?parent=" + attributes
        var location = url + path
        Alamofire.request(.GET, location)
            .responseJSON() {
                (req, res, json, error) in
                
                if(error != nil) {
                    NSLog("GET Error: \(error)")
                    println(res)
                }
                else {
                    var json = JSON(json!)
                    //                    NSLog("GET Result: \(json)")
                    self.didReceiveResult(json)
                    
                }
        }
    }
    
    func didReceiveResult(result: JSON) {
        
        for (index: String, item: JSON) in result {
            var attributes: Array<[String: String]> = []
            
            for (index1: String, event: JSON) in item {
                var airports = [String: String]()
                NSLog("item string \(event.string)")
                for (index2: String, children: JSON) in event {
                    NSLog("child string \(children.string)")
                }
                //                NSLog("index1 \(index)")
                //                NSLog("index1 \(event)")
                airports[index] = event.string //.boolValue
                //                for (a: String, b: JSON) in event {
                //                    NSLog("index2 \(airports)")
                attributes.append(airports)
                self.data.append(
                    //            self.data.addObject(
                    
                    Hospital(
                        location_name: event.stringValue,
                        location_id: index1
                    )
                )
                
                //                }
            }
            
            //                NSLog("item \(event)")
            //             = item.each{ $0 } //.map { $0.string!}
            
        }
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var key = data[indexPath.row]
        self.tap(key)
    }
    
    func tap(key: Hospital){
        var vc = ServicesController()
//        NSLog("\(key.location_id)")
        vc.attributes = key.location_id.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        vc.data = [Hospital]()
        if count(key.location_id) < 7 {
            self.navigationController!.pushViewController(vc, animated:true)
        } else {
//            var vc = PatentController()
            let storyboard = UIStoryboard(name: "Patent", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("patentController") as! PatentController
            vc.ipc_code = "A61K38/08"
//            self.presentViewController(vc, animated: true, completion: nil)
            self.navigationController!.pushViewController(vc, animated:true)
//            NSLog("WE have a patent!\(key.location_id)")
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var hospital = data[indexPath.row] //as! Hospital
        var cell_ : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("HospitalCell") as? UITableViewCell
        if(cell_ == nil)
        {
            cell_ = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "HospitalCell")
        }
//        var name = hospital.keys.first as String?
        cell_!.textLabel!.text = hospital.location_name //"aa" //TitleCase(name!) //hospital as String? //hospital.location_name
//        if hospital.values.first == false {
//            var iv = UIImageView(image: UIImage(named: "cross"))
//            iv.contentMode = .ScaleAspectFit
//            cell_!.accessoryView = iv
//            cell_!.accessoryView!.frame = CGRectMake(0, 0, 24, 24)
//        } else {
//            var iv = UIImageView(image: UIImage(named: "tick"))
//            iv.contentMode = .ScaleAspectFit
//            cell_!.accessoryView = iv
//            cell_!.accessoryView!.frame = CGRectMake(0, 0, 24, 24)
//        }
        return cell_!
    }
    
    func TitleCase(str: String) -> String {
        //
        // Create an array of words to make lower case.
        //
        let lower = ["to", "an", "and", "at", "as", "but", "by", "for", "if", "in", "on", "or", "is", "with", "a", "the", "of", "vs", "vs.", "via", "via", "en"]
        
        //
        // Create an array of words that are to be upper cased.
        //
        let upper = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "HTML", "CSS", "AT&T", "PHP"]
        
        //
        // Split the string by spaces.
        //
        var words = str.componentsSeparatedByString("_")
        
        //
        // initialize helper variables.
        //
        var result = ""
        var first = true
        
        //
        // Loop through each word.
        //
        for word in words {
            //
            // Create a lower case of the word and the result word as capitalized.
            //
            var lword = word.lowercaseString
            var res = word.capitalizedString
            
            //
            // Loop through each word that should be lower case.
            //
            for low in lower {
                if lword == low.lowercaseString {
                    //
                    // It should be lower case.  Set the result word to it and break
                    // out of the loop.
                    //
                    res = low
                    break
                }
            }
            
            //
            // Loop through each word that should be uppercased.
            //
            for up in upper {
                if lword == up.lowercaseString {
                    //
                    // It should be uppercase. Set the result word and break out.
                    //
                    res = up
                    break
                }
            }
            
            //
            // If it is the first word, then always capitalize.
            //
            if first {
                res = res.capitalizedString
                first = false
            }
            
            //
            // Create the resulting string.
            //
            result += "\(res) "
        }
        
        //
        // Return the result.
        //
        return(result)
    }
    
    
}

