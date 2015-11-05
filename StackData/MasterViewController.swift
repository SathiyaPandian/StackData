//
//  MasterViewController.swift
//  StackData
//
//  Created by BB&T Macbook on 10/26/15.
//  Copyright © 2015 Sathiya Macbook. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Repository]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         jsonParsingStructure ()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   func jsonParsingStructure () {
    
    let jsonUrl = "https://api.stackexchange.com/2.2/users/1174526;2517849;2521532?site=stackoverflow.com"
    let session = NSURLSession.sharedSession()
    let shotsUrl = NSURL(string: jsonUrl)
    let task = session.dataTaskWithURL(shotsUrl!) {
        (data, response, error) -> Void in
        
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                
                
                if let reposArray = jsonResult["items"] as? [NSDictionary] {
                    for item in reposArray {
                        // construct your model objects here
                        self.objects.append(Repository(json: item))
                        
                    }
                }
                print(self.objects.count)
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        } catch {
            print(error)
        }
    }
    task.resume()

    }
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row].link_url
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.link = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if cell.imageView?.image == nil,
            let imgURL = self.objects[indexPath.row].image_url {
            cell.imageView?.image = UIImage()
            getImageForCell(imgURL, cellForRowAtIndexPath: indexPath)
        }
        cell.textLabel?.text = self.objects[indexPath.row].name
        cell.detailTextLabel?.text = self.objects[indexPath.row].location
        return cell
    }

    func getImageForCell(urlString: String, cellForRowAtIndexPath indexPath: NSIndexPath) {
        var image: UIImage?
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            if let myImageData = NSData(contentsOfURL: NSURL(string:urlString)!) {
               image =  UIImage(data: myImageData)
            } else {
                print("No Data")
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                 if image != nil {
                let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
                cell.imageView?.image = image
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                 } else {
                    print("No Image")
                }
            }
        }
    }
    
}

