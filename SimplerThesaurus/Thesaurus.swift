//
//  Thesaurus.swift
//  Simpler
//
//  Created by Morten Just Petersen on 4/3/16.
//  Copyright © 2016 Morten Just Petersen. All rights reserved.
//



import Cocoa


struct ThesaurusItem {
    var word:String
    var synonyms:[String]
}

class Thesaurus: NSObject {
    static let sharedInstance = Thesaurus()
    
    var thesaurus:[ThesaurusItem]!
    
    override init() {
        super.init()
        let fileContents = loadFromFile()
        self.thesaurus = generateDictionaryFromRawString(fileContents)
    }
    
    func synonymsForWord(word:String) -> [String]!{
        for w in thesaurus {
            if w.word == word {
                return w.synonyms
            }
        }
        return nil
    }
    
    
    
    
    /// helpers
    
    func generateDictionaryFromRawString(rawString:String) -> [ThesaurusItem]{
        let allRawEntries = rawString.componentsSeparatedByString("\n")
        
        var fullDictionary = [ThesaurusItem]()
        for rawEntry in allRawEntries {
            let components = rawEntry.componentsSeparatedByString(",")
            let word = components[0]
            
            var synonyms = [String]()
            for component in components {
                synonyms.append(component)
            }
            
            let thesaurusItem = ThesaurusItem(word: word, synonyms: synonyms)
            fullDictionary.append(thesaurusItem)
        }
        
        return fullDictionary
    }
    
    
    func loadFromFile() -> String! {
        let fileName = "thesaurus-en.txt"
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "")!
        do {
            let text = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            return text as String
        } catch {
            print("read didn't work")
            return nil
        }
    }
    
    
}

// usage example
//
//// delete all this after a while, testing thesaurus
//print("starting thesaurus...")
//let t = Thesaurus.sharedInstance
//print("looking up plant")
//
//var r = t.synonymsForWord("initial")
//print("results: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("product")
//print("\n\n\nNEproduc: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("performance")
//print("\n\n\nNEperform: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("electric")
//print("\n\n\nNEelectir: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("sport")
//print("\n\n\nNEsports: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("aware")
//print("\n\n\nNEaware: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("range")
//print("\n\n\nRANGE: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("term")
//print("\n\n\nTERM: \(filterSimpleWords(r))")
//
//
//r = t.synonymsForWord("model")
//print("\n\n\nMODEL: \(filterSimpleWords(r))")
//
//r = t.synonymsForWord("including")
//print("\n\n\nINCLUDING: \(filterSimpleWords(r))")
//
////        r = t.synonymsForWord("affordability")
////        print("\n\n\nNEaffordability: \(filterSimpleWords(r))")
////
//r = t.synonymsForWord("price")
//print("\n\n\nPRICED: \(filterSimpleWords(r))")
//
//
//}
//
//func filterSimpleWords(words:[String])->[String]{
//    var r = [String]()
//    for w in words {
//        if SimpleWords.sharedInstance.isSimpleWord(w){
//            r.append(w)
//        }
//    }
//    return r
//}
