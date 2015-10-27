//
//  DetailViewController.swift
//  StackData
//
//  Created by BB&T Macbook on 10/26/15.
//  Copyright © 2015 Sathiya Macbook. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var navBack: UIBarButtonItem!
    @IBOutlet var navForward: UIBarButtonItem!
    @IBOutlet var toolbar: UIToolbar!

    

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        
        if let fetchURL = NSURL(string: self.link! ) {
            let urlRequest = NSURLRequest(URL: fetchURL)
            self.webView.loadRequest(urlRequest)
        }

    }
    
var link: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Webview delegate
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        // stop spinner
        self.activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        // stop spinner
        self.activityIndicator.stopAnimating()
        
        // show error message
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading url.")
    }
    
    
    
    
    // MARK: - Utility function
    
    // refresh webview
    func refreshWebView(){
        
        // start spinner
        self.activityIndicator.startAnimating()
        
        // reload webview
        self.webView.reload()
        
    }
    
    
    // show alert with ok button
    private func showAlertMessage(alertTitle alertTitle: String, alertMessage: String ) -> Void {
        
        // create alert controller
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert) as UIAlertController
        
        // create action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
            { (action: UIAlertAction) -> Void in
                // you can add code here if needed
        })
        
        // add ok action
        alertCtrl.addAction(okAction)
        
        // present alert
        self.presentViewController(alertCtrl, animated: true, completion: { (void) -> Void in
            // you can add code here if needed
        })
    }
    
    func goBack(){
        
        if(self.webView.canGoBack){
            self.webView.goBack()
        }
        
    }
    
    func goForward() {
        
        if(self.webView.canGoForward){
            self.webView.goForward()
        }
    }
}


