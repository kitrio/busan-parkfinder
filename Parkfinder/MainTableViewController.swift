//
//  MainTableViewController.swift
//  Parkfinder
//
//  Created by j lee on 2017. 11. 28..
//  Copyright © 2017년 jea. All rights reserved.
//

import UIKit

class MainTableViewController:UIViewController,UITableViewDataSource,UITableViewDelegate,XMLParserDelegate{

    @IBOutlet var MainTableView: UITableView!
    let apikey = "GX4ChytuKBVS%2FDf%2FqalqSj10m7C1SfiuIoxfZKQRGfIP6yf5gnyI1B%2FCIZOJ24JSuVNpeGNiIU53VFEqxO7O9A%3D%3D"
    
    let endUrl = "http://opendata.busan.go.kr/openapi/service/CityPark/getCityParkInfoList"
    let detailUrl = "http://opendata.busan.go.kr/openapi/service/CityPark/getCityParkInfoDetail"
    //let numOfRow = 1
    //let pageSizeNo = 10
    var totalCount = 0
    var item : [String:String] = [:]
    var items : [[String:String]] = []
    var keyElement = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainTableView.delegate = self
        MainTableView.dataSource = self
        getTotal(numOfRow : totalCount)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
    }

    func getTotal(numOfRow: Int){
        
        let strUrl = "\(endUrl)?serviceKey=\(apikey)&numOfRows=\(numOfRow)&totalCount=\(totalCount)"
        if let url = URL(string: strUrl){
            if let parser = XMLParser(contentsOf: url){
                parser.delegate = self
                let success = parser.parse()
                if success{
                    print(strUrl)
                    print("parsing success")
                }else {
                    print("parsing failed")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        keyElement = elementName
        if keyElement == "item" {
            //keyElement = elementName
            item = [:]
            
        }
    }
    func parser(_ parser: XMLParser, foundCharacters foundstring: String) {
        if item[keyElement] == nil{
            
            item[keyElement] = foundstring.trimmingCharacters(in: .whitespaces)
            
            if keyElement == "totalCount"{
                totalCount = Int(foundstring.trimmingCharacters(in: .whitespaces))!
            }
            print("keyisnil\(item)")
            
            
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            items.append(item)
            print(items)
            print("-------------------------------")
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let element  = items[indexPath.row]
        cell.textLabel?.text = element["parkName"]
        cell.detailTextLabel?.text = element["parkType"]
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
