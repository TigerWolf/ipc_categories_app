//
//  ViewController.swift
//  Hospitals
//
//  Created by a1673450 on 30/06/2015.
//  Copyright (c) 2015 Kieran. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class HospitalController: UITableViewController, UISearchResultsUpdating {
    
    var data = [Hospital]()
    var filteredData = [Hospital]()
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Australian Patent Search Tool"
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        // This is needed so that search bar doesnt fly away
        self.definesPresentationContext = true
        var b = UIBarButtonItem(title: "Advanced Search", style: .Plain, target: self, action: "openPhoto:")
        self.navigationItem.rightBarButtonItem = b
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
//        var url = "http://localhost:3000/"
        var url = "http://digitalhub.unleashingsa.com.au/"
        var path = "api/v1/categories/list"
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
                                NSLog("item string \(index1)")
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
        
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController.active) {
            return self.filteredData.count
        }else {
            return self.data.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell_ : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("HospitalCell") as? UITableViewCell
        if(cell_ == nil)
        {
            cell_ = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "HospitalCell")
        }
        
        var hospital : Hospital
        
        if (self.searchController.active) {
            hospital = filteredData[indexPath.row]
        } else {
            hospital = data[indexPath.row]
        }
        
        cell_!.textLabel!.text = hospital.location_name
        cell_!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell_!
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if(segue.identifier == "showHospitalDetail") {
    
            if let servicesController = (segue.destinationViewController as? ServicesController) {

                if let row = tableView.indexPathForSelectedRow()?.row {
                    NSLog("\(row)")
                    if let hospital = self.data[row] as? Hospital  { //
//                        NSLog("\(hospital.attributes)")
                        servicesController.attributes = hospital.location_id
//                        yourNextViewController.tableView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        NSLog("FILTERING")
        // Filter the array using the filter method
        self.filteredData = self.data.filter({( data: Hospital) -> Bool in
//            let categoryMatch = (scope == "All") || (candy.category == scope)
            let stringMatch = data.location_name.rangeOfString(searchText)
            return  (stringMatch != nil) //categoryMatch &&
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        self.filteredData = self.data.filter({( data: Hospital) -> Bool in
            //            let categoryMatch = (scope == "All") || (candy.category == scope)
            let stringMatch = data.location_name.rangeOfString(searchController.searchBar.text)
            return  (stringMatch != nil) //categoryMatch &&
        })
        self.tableView.reloadData()
    }
    
//    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
//        self.filterContentForSearchText(searchString)
//        return true
//    }
//    
//    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
//        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
//        return true
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: Fix up when clicking on search items only.
        //self.performSegueWithIdentifier("showHospitalDetail", sender: tableView)
    }
    
    func openPhoto(sender: UIBarButtonItem){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Photo", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("pc") as! PhotoController
//        self.navigationController!.presentViewController(nextViewController, animated:true, completion:nil)
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    

}

