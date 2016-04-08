//
//  ViewController.swift
//  SimplerThesaurus
//
//  Created by Morten Just Petersen on 4/4/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var win : NSWindow!
    @IBOutlet var allSynonymsField: NSTextView!
    @IBOutlet var simpleSynonymsField: NSTextView!
    @IBOutlet weak var searchField: NSSearchField!
    
    @IBAction func searchHappened(sender: AnyObject) {
        
        let syns = Thesaurus.sharedInstance.synonymsForWord(searchField.stringValue)
    
        if syns == nil {
            resetFields()
            return }
        
        var allSyns = ""
        for syn in syns {
            allSyns = "\(allSyns), \(syn)"
        }
        
        allSynonymsField.string = trim(allSyns)
        
        var allSimple = ""
        for simple in filterSimpleWords(syns) {
            allSimple = "\(allSimple), \(simple)"
        }
        
        simpleSynonymsField.string = trim(allSimple)
        
    }
    
    func trim(s:String)->String{
        return s.stringByTrimmingCharactersInSet(NSCharacterSet.punctuationCharacterSet()).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    
    func filterSimpleWords(words:[String])->[String]{
        var r = [String]()
        for w in words {
            if SimpleWords.sharedInstance.isSimpleWord(w){
                r.append(w)
            }
        }
        return r
    }
    
    func setSimpleWordsFormatting(){
        let editorBackgroundColor = NSColor(red:0.988, green:0.988, blue:0.980, alpha:1)
        let editorTextColor = NSColor(red:0.349, green:0.349, blue:0.314, alpha:1)
        let editorFont = NSFont(name: "Avenir Next", size: 23)
        
        simpleSynonymsField.font = editorFont!
        simpleSynonymsField.textColor = editorTextColor
        simpleSynonymsField.backgroundColor = editorBackgroundColor
        
    }
    
    
    func resetFields(){
        allSynonymsField.string = ""
        simpleSynonymsField.string = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load the singleton on app load, takes a little while
        let _ = Thesaurus.sharedInstance.synonymsForWord("start")
        
        setSimpleWordsFormatting()

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    override func viewWillAppear() {
        win = self.view.window!
        win.titlebarAppearsTransparent = true
        win.movableByWindowBackground = true
        win.title = ""
    }

}

