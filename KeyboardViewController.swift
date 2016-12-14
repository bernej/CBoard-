//
//  KeyboardViewController.swift
//  CBoard
//
//  Created by Brennan Zimmer on 11/1/16.
//  Copyright © 2016 Brennan Zimmer. All rights reserved.
//

import UIKit
import Foundation

class KeyboardViewController: UIInputViewController {
    
    var keyboardView: UIView!
    
    //To know when you come from the loop keyboard
    var fromLoop = false
    
    //To know if you came from import lirary
    var fromLibrary = false
    
    //TO know if you came from contain keyboard
    var fromContainer = false
    
    //Count to keep track of home button for container
    var containerPathCount = 0
    var libraryPathCount = 0
    
    //hold delete (in dev.)
    var binaryCount = 0b0000
    var timer = Timer()

    //flag indicating whether the variables were just cleared from useVariable
    var clearedVariables = false
    var clearedDatatypes = false
    
    //Buttons to display variables
    @IBOutlet var collectionOfButtons: Array<UIButton>?
    @IBOutlet var collectionOfButtons2: Array<UIButton>?
    
    //variables to save our list of variables and custom data types
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let DataTypeDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("variables")
    static let TypesArchiveURL = DataTypeDirectory.appendingPathComponent("customDataTypes")

    
    //Label for Variable Storage and to know which xib we are in
    @IBOutlet weak var variableLabel: UILabel?
    var inStoreVariable = false //Not in store variable keyboard
    var variableArray = [String]()
    
    var inDataType = false
    var dataTypeArray = [String]()
    
    
    @IBAction func buttonTap(){
        fromContainer = true
        containerPathCount = 0
        let containerNib = UINib(nibName: "container", bundle: nil)
        keyboardView = containerNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func variableTap(_ sender: AnyObject) {
        variableLabel?.text = ""
        let variableNib = UINib(nibName: "variable", bundle: nil)
        keyboardView = variableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func deleteVariableTap(_ sender: AnyObject) {
        let deleteVariableNib = UINib(nibName: "deleteVariable", bundle: nil)
        keyboardView = deleteVariableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    

    
    @IBAction func createVariableTap(){
        variableLabel?.text = ""
        containerPathCount = 1
        let createVariableNib = UINib(nibName: "dataType", bundle: nil)
        keyboardView = createVariableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        
    }
    
    @IBAction func loopsTap(_ sender: AnyObject) {
        let createVariableNib = UINib(nibName: "loops", bundle: nil)
        keyboardView = createVariableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    @IBAction func nameVariableTap(_ sender: AnyObject) {
        inStoreVariable = true
        inDataType = false
        let nameVariableNib = UINib(nibName: "variable", bundle: nil)
        keyboardView = nameVariableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func deleteSomeVariableTap(_ sender: AnyObject) {
        let variableListDeleteNib = UINib(nibName: "variableListDelete", bundle: nil)
        keyboardView = variableListDeleteNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        displayVariables()
    }
    
    @IBAction func deleteSomeDataTypeTap(_ sender: AnyObject) {
        let dataTypeDeleteNib = UINib(nibName: "dataTypeDelete", bundle: nil)
        keyboardView = dataTypeDeleteNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        displayDataTypes()
    }
    
    @IBAction func storeVariable(_ sender: AnyObject) {
        //Store Variables
        if (inStoreVariable && variableArray.index(of: (variableLabel?.text)!) == nil) {
            if (!clearedVariables) {
                variableArray = loadVariables()
            } else {
                clearedVariables = false
            }
            variableArray.append((variableLabel?.text)!)
            saveVariables()
        }
        inStoreVariable = false
        fromContainer = false
        //Store Data types
        if (inDataType && dataTypeArray.index(of: (variableLabel?.text)!) == nil) {
            if (!clearedDatatypes) {
                dataTypeArray = loadDataTypes()
            } else {
                clearedDatatypes = false
            }
            dataTypeArray.append((variableLabel?.text)!)
            saveDataTypes()
        }
        inDataType = false
        
        if (fromLoop) {
            fromLoop = false
            let loopsNib = UINib(nibName: "loops", bundle: nil)
            keyboardView = loopsNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        } else {
            let storeVariableNib = UINib(nibName: "keyboard", bundle: nil)
            keyboardView = storeVariableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        }
        
    }
    @IBAction func alphaNumericTap(){
        let alphaNumericsNib = UINib(nibName: "alphaNumerics", bundle: nil)
        keyboardView = alphaNumericsNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        
    }
    
    @IBAction func libraryTap() {
        fromLibrary = true
        libraryPathCount = 0
        let libraryNib = UINib(nibName: "library", bundle: nil)
        keyboardView = libraryNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func loopsTap(){
        let loopsNib = UINib(nibName: "loops", bundle: nil)
        keyboardView = loopsNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func createDatatypeTap(_ sender: AnyObject) {
        inDataType = true
        inStoreVariable = false
        let createDatatypeNib = UINib(nibName: "createDatatype", bundle: nil)
        keyboardView = createDatatypeNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func homeTap(){
        inStoreVariable = false
        inDataType = false
        
        //If/else loop indicates what view user was on before hitting back button
        if (fromLoop) {
            fromLoop = false
            let loopsNib = UINib(nibName: "loops", bundle: nil)
            keyboardView = loopsNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        } else if (fromLibrary && libraryPathCount > 0) {
            libraryPathCount = 0
            let libraryNib = UINib(nibName: "library", bundle: nil)
            keyboardView = libraryNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        } else if (fromContainer && containerPathCount > 0) {
            containerPathCount = 0
            let containerNib = UINib(nibName: "container", bundle: nil)
            keyboardView = containerNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        } else {
            fromContainer = false
            fromLibrary = false
            fromLoop = false
            let keyboardNib = UINib(nibName: "keyboard", bundle: nil)
            keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        }
    
    }
    
    @IBAction func deleteButton(_ sender: AnyObject?) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }
    
    //Hold delete functionality... still in dev.
/*
 *   func countUp() {
 *       let proxy = textDocumentProxy as UITextDocumentProxy
 *       binaryCount += 0b0001
 *       if (binaryCount == 0b10000) { binaryCount = 0b0000 }
 *       proxy.deleteBackward()
 *   }
 *
 *   @IBAction func start(_ sender: UIButton) {
 *       timer = Timer(timeInterval: 0.25, target: self, selector: #selector(KeyboardViewController.countUp), userInfo: nil, repeats: true)
 *       RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
 *   }
 *
 *   @IBAction func reset() {
 *       timer.invalidate()
 *       binaryCount = 0b0000
 *   }
 */
    
    @IBAction func deleteLabel (_ sender: UIButton) {
        var name: String = variableLabel!.text!
        if (name.characters.count > 0) {
            name.remove(at: name.index(before: name.endIndex))
            variableLabel?.text = name
        }
    }
    
    @IBAction func newlineTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("\n")
    }
    
    @IBAction func newlineSemicolonTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(";\n")
    }
    
    
    //Container Buttons
    @IBOutlet weak var queueButton: UIButton!
    
    @IBOutlet weak var vectorButton: UIButton!
    
    @IBOutlet weak var stackButton: UIButton!
    
    @IBOutlet weak var dequeButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    

    
    //************Container Buttons*********************************************
    
    @IBAction func queueTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("queue<")
    }
    @IBAction func vectorTap(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("vector<")
    }
    
    @IBAction func stackTap(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("stack<")
    }
    
    @IBAction func dequeTap(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("deque<")
    }
    
    @IBAction func listTap(){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("list<")
    }

    //*************End Container Buttons*****************************************
    

    
    
    //*************Home Keyboard Buttons********************************
    
    @IBAction func parenthTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("()")
        proxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @IBAction func curlyBraceTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("{\n\t\n}")
        proxy.adjustTextPosition(byCharacterOffset: -2)
    }
    
    @IBAction func bracketTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("[]")
        proxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @IBAction func coutTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("cout << ")
    }
    
    @IBAction func cinTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("cin >> ")
    }
    
    @IBAction func endlTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("<< endl")
    }
    
    @IBAction func ifelseTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("if () {\n\t\n} else {\n\t\n}")
        proxy.adjustTextPosition(byCharacterOffset: -18)
    }
    

    @IBAction func commentTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("// ")
    }
    
    @IBAction func ifTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("if () {\n\t\n}")
        proxy.adjustTextPosition(byCharacterOffset: -7)
    }
    @IBAction func semiColonTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(";")
    }
    
    @IBAction func quoteTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("\"\"")
        proxy.adjustTextPosition(byCharacterOffset: -1)
    }
    
    @IBAction func commaTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(", ")
    }
    
    @IBAction func periodTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(".")
    }
    
    @IBAction func equalTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("=")
    }
    
    
    @IBAction func asteriskTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("*")
    }
    
    @IBAction func minusTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("-")
    }
    
    
    @IBAction func addTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("+")
    }
    
    @IBAction func divideTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("/")
    }
    
    
    @IBAction func lessThanTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("<")
    }
    
    @IBAction func greaterThanTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(">")
    }
    
    @IBAction func ampTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("&")
    }
    
    @IBAction func pipeTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("|")
    }
    
    @IBAction func exclamationTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("!")
    }
    
    
    @IBAction func returnTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("return")
    }
    
    @IBAction func spaceTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(" ")
    }
    
    @IBAction func tabTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("    ")
    }
    //*************End Home Keyboard Buttons********************************

    
    
    //*************Alphanumeric Keyboard Buttons********************************
    
    //Collection of letters on the alphaNumeric keyboard; each are added to
    //the variable label in the variable CBoard if user is in that view
    @IBOutlet var letterArray: Array<UIButton>?
    //flag to indicate whether shift is enabled
    var shift = false;
    
    @IBAction func shiftTap(_ sender: AnyObject) {
        var i = 0
        if (!shift) {
            for object in letterArray! {
                object.setTitle((object.titleLabel?.text)?.uppercased(), for: .normal)
                i += 1
            }
            shift = true;
            sender.titleLabel??.font = UIFont.boldSystemFont(ofSize: 27)
        } else {
            for object in letterArray! {
                object.setTitle((object.titleLabel?.text)?.lowercased(), for: .normal)
                i += 1
            }
            shift = false;
            sender.titleLabel??.font = UIFont.systemFont(ofSize: 27)
        }
    }

    @IBAction func letterTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        let tempString = (sender.titleLabel!.text!)
        proxy.insertText(tempString)
        if (inStoreVariable || inDataType) {
            variableLabel?.text = (variableLabel?.text!)! + tempString
        }
    }
    
    @IBAction func underscoreTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("_")
        variableLabel?.text = (variableLabel?.text!)! + "_"
    }
    
    @IBAction func zeroTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("0")
        variableLabel?.text = (variableLabel?.text!)! + "0"
    }
    
    @IBAction func oneTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("1")
        variableLabel?.text = (variableLabel?.text!)! + "1"
    }
    
    @IBAction func twoTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("2")
        variableLabel?.text = (variableLabel?.text!)! + "2"
    }
    
    @IBAction func threeTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("3")
        variableLabel?.text = (variableLabel?.text!)! + "3"
    }
    
    @IBAction func fourTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("4")
        variableLabel?.text = (variableLabel?.text!)! + "4"
    }
    
    @IBAction func fiveTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("5")
        variableLabel?.text = (variableLabel?.text!)! + "5"
    }
    
    @IBAction func sixTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("6")
        variableLabel?.text = (variableLabel?.text!)! + "6"
    }
    
    
    @IBAction func sevenTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("7")
        variableLabel?.text = (variableLabel?.text!)! + "7"
    }
    
    @IBAction func eightTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("8")
        variableLabel?.text = (variableLabel?.text!)! + "8"
    }
    
    @IBAction func nineTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("9")
        variableLabel?.text = (variableLabel?.text!)! + "9"
    }
    
    //*************End Alphanumeric Keyboard Buttons****************************
    
    
    //*************Use Variable Display*****************************************
    
    @IBAction func useVariableTap(_ sender: UIButton) {
        let variableListNib = UINib(nibName: "variableList", bundle: nil)
        keyboardView = variableListNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        
        displayVariables()
    }
    
    func displayVariables() {
        //load variables from iPad's memory, if they weren't "deleted" by user
        if (!clearedVariables) {
            variableArray = loadVariables()
        } else {
            clearedVariables = false
        }
        
        //Sort variable array alphabetically
        var sorted_arr = [String]()
        sorted_arr = variableArray.sorted{$0 < $1}
        
        //Fill up button collection on use variable/function CBoard
        var i = 0
        for object in collectionOfButtons! {
            if (i >= variableArray.count) {
                //Storage capacity reached.
                break;
            }
            if (i < variableArray.count) {
                object.isEnabled = true
                object.setTitle(sorted_arr[i], for: .normal)
            }
            i += 1
        }
    }
    
    @IBAction func clearVariables(_ sender: AnyObject) {
        for object in collectionOfButtons! {
            object.isEnabled = false
            object.setTitle("", for: .normal)
        }
        variableArray.removeAll()
        saveVariables()
        clearedVariables = true
    }
    
    @IBAction func clearVariable(  sender: UIButton) {
        if (sender.isEnabled) {
            if let index = variableArray.index(of: (sender.titleLabel?.text!)!) {
                variableArray.remove(at: index)
            }
            saveVariables()
            sender.backgroundColor = UIColor.red
            sender.setTitle("Deleted", for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func selectVariableTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(((sender.titleLabel?.text!)! + " "))
        inDataType = false
    }
    //*************End Use Variable Display*************************************
    //*************Save and Loading Functionality to iPad memory****************
    func saveVariables() {
        let isSaveSuccessful = NSKeyedArchiver.archiveRootObject(variableArray, toFile: KeyboardViewController.ArchiveURL.path)
        if (!isSaveSuccessful) {
            print("Save didn't work")
        }
    }
    
    func saveDataTypes() {
        let isSaveSuccessful = NSKeyedArchiver.archiveRootObject(dataTypeArray, toFile: KeyboardViewController.TypesArchiveURL.path)
        if (!isSaveSuccessful) {
            print("Save didn't work")
        }
    }
    
    func loadVariables() -> [String] {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: KeyboardViewController.ArchiveURL.path) as? [String])!
    }
    
    func loadDataTypes() -> [String] {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: KeyboardViewController.TypesArchiveURL.path) as? [String])!
    }
    //*************End Save and Loading Functionality to iPad memory************
    
    
    
    //*************Loops Keyboard***********************************************
    @IBAction func forTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("for() {\n\t\n}")
        proxy.adjustTextPosition(byCharacterOffset: -7)
        
    }
    
    @IBAction func whileTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("while() {\n\t\n}")
        proxy.adjustTextPosition(byCharacterOffset: -7)

    }
    
    @IBAction func switchTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("switch() {\n\tcase()\n\t\tbreak;\n}")
        proxy.adjustTextPosition(byCharacterOffset: -23)
    }
    
    @IBAction func loopHomeCboardTap(_ sender: AnyObject) {
        let keyboardNib = UINib(nibName: "keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func loopCreateVariable(_ sender: AnyObject) {
        fromLoop = true
    }
    @IBAction func loopUseVariable(_ sender: AnyObject) {
        fromLoop = true
    }
    @IBAction func loopAlphaNumeric(_ sender: AnyObject) {
        fromLoop = true
    }
    //*************End Loops Keyboard*******************************************

    
    //*************dataTypeStore Keyboard***************************************
    @IBAction func dataTypeOtherTap(_ sender: UIButton) {
        inDataType = true
        //let proxy = textDocumentProxy as UITextDocumentProxy
        let dataTypeListNib = UINib(nibName: "dataTypeStore", bundle: nil)
        dataTypeArray = loadDataTypes()
        keyboardView = dataTypeListNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        displayDataTypes()
    }
    
    func displayDataTypes() {
        //load variables from iPad's memory, if they weren't "deleted" by user
        if (!clearedDatatypes) {
            dataTypeArray = loadDataTypes()
        } else {
            clearedDatatypes = false
        }
        
        var sorted_arr = [String]()
        //Sort variable array alphabetically
        sorted_arr = dataTypeArray.sorted{$0 < $1}
        
        var i = 0
        for object in collectionOfButtons2! {
            if (i >= dataTypeArray.count) {
                //Storage capacity reached.
                break;
            }
            object.isEnabled = true
            if (i < dataTypeArray.count) {
                object.setTitle(sorted_arr[i], for: .normal)
            }
            i += 1
        }
    }
    
    @IBAction func clearDatatypes(_ sender: AnyObject) {
        for object in collectionOfButtons2! {
            object.isEnabled = true
            object.setTitle("", for: .normal)
        }
        dataTypeArray.removeAll()
        saveDataTypes()
        clearedDatatypes = true
    }
    
    @IBAction func clearDataType(  sender: UIButton) {
        if (sender.isEnabled) {
            if let index = dataTypeArray.index(of: (sender.titleLabel?.text!)!) {
                dataTypeArray.remove(at: index)
            }
            saveDataTypes()
            sender.backgroundColor = UIColor.red
            sender.setTitle("Deleted", for: .normal)
            sender.setTitleColor(UIColor.white, for: .normal)
        }
    }
    //*************End dataTypeStore Keyboard***********************************
    
    
   //*************Library Keyboard**********************************************
    @IBAction func libraryTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        let tempString = (sender.titleLabel!.text!)
        proxy.insertText("#include <" + tempString + ">\n")
    }

    @IBAction func otherLibraryTap(_ sender: UIButton) {
        libraryPathCount = 1
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("#include \"\"")
        let alphaNumericsNib = UINib(nibName: "alphaNumerics", bundle: nil)
        keyboardView = alphaNumericsNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        proxy.adjustTextPosition(byCharacterOffset: -1)
        view.addSubview(keyboardView)
        
    }
    @IBAction func namespace_stdTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        let tempString = (sender.titleLabel!.text!)
        proxy.insertText(tempString + "\n")
    }
    //*************End LibraryKeyboard***********************************************

   //*************CreateDataType Keyboard**************************************************
    @IBAction func classTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("class  {\n\tprivate:\n\t\t\n\tpublic:\n\t\t\n}")
        proxy.adjustTextPosition(byCharacterOffset: -29)
    }
    
    @IBAction func structTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("struct  {\n\t\n};")
        proxy.adjustTextPosition(byCharacterOffset: -7)
    }
    
    @IBAction func enumTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("enum  {  };")
        proxy.adjustTextPosition(byCharacterOffset: -6)
    }
    
    
    //*************End createDataType***********************************************
    
     //************Data Type Buttons*****************
    
    @IBAction func intTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: "int")
    }
    
    @IBAction func stringTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: "string")
    }
    
    @IBAction func doubleTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: "double")
    }
    
    @IBAction func charTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: "char")
    }
    
    @IBAction func boolTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: "bool")
    }
    
    @IBAction func voidTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: "void")
    }
    
    @IBAction func selectOtherTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        dataTypeCheck(proxy: proxy, type: (sender.titleLabel?.text!)!)
    }
    
    //Function to check whether user needs to datatype for container or not.
    func dataTypeCheck(proxy: UITextDocumentProxy, type: String){
        let str = proxy.documentContextBeforeInput
        let lastChar = str?[(str?.index(before: (str?.endIndex)!))!]
        if (lastChar == "<") {
            proxy.insertText(type + "> ")
        } else {
            proxy.insertText(type + " ")
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    @IBAction func nextKeyboardTap(_ sender: AnyObject) {
        advanceToNextInputMode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        //        self.nextKeyboardButton = UIButton(type: .system)
        //
        //        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        //        self.nextKeyboardButton.sizeToFit()
        //        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        //
        //        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        //
        //        self.view.addSubview(self.nextKeyboardButton)
        //
        //        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        //        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        loadInterface()
    }
    
    func loadInterface(){
        let keyboardNib = UINib(nibName: "keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        //        var textColor: UIColor
        //        let proxy = self.textDocumentProxy
        //        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
        //            textColor = UIColor.white
        //        } else {
        //            textColor = UIColor.black
        //        }
        //        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
}
