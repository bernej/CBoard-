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
    var fromLoop = false;
    
    
    //Buttons to display variables

    @IBOutlet var collectionOfButtons: Array<UIButton>?
    
    //Label for Variable Storage and to know which xib we are in
    @IBOutlet weak var variableLabel: UILabel?
    var inStoreVariable = false //Not in store variable keyboard
    var variableArray = [String]()
    
    
    @IBAction func buttonTap(){
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
    
    @IBAction func createVariableTap(){
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
        let nameVariableNib = UINib(nibName: "variable", bundle: nil)
        keyboardView = nameVariableNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func storeVariable(_ sender: AnyObject) {
        inStoreVariable = false
        variableArray.append((variableLabel?.text)!)
        
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
        let createDatatypeNib = UINib(nibName: "createDatatype", bundle: nil)
        keyboardView = createDatatypeNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
    }
    
    @IBAction func homeTap(){
        if (fromLoop) {
            fromLoop = false
            let loopsNib = UINib(nibName: "loops", bundle: nil)
            keyboardView = loopsNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        } else {
            let keyboardNib = UINib(nibName: "keyboard", bundle: nil)
            keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as! UIView
            view.addSubview(keyboardView)
        }
    
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        if (inStoreVariable) {
            var name: String = variableLabel!.text!
            if (name.characters.count > 0) {
                proxy.deleteBackward()
                name.remove(at: name.index(before: name.endIndex))
                variableLabel?.text = name
            }
        } else {
            proxy.deleteBackward()
        }

    }
    @IBAction func deleteButtonHold(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        if (inStoreVariable) {
            var name: String = variableLabel!.text!
            if (name.characters.count > 0) {
                proxy.deleteBackward()
                name.remove(at: name.index(before: name.endIndex))
                variableLabel?.text = name
            }
        } else {
            proxy.deleteBackward()
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
        proxy.insertText("{}")
        proxy.adjustTextPosition(byCharacterOffset: -1)
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
        proxy.insertText("if () {\n\n} else {\n\n\n}")
        proxy.adjustTextPosition(byCharacterOffset: -17)
    }
    

    @IBAction func commentTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("// ")
    }
    
    @IBAction func ifTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("if () {\n\n}")
        proxy.adjustTextPosition(byCharacterOffset: -6)
    }
    @IBAction func semiColonTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(";")
    }
    
    @IBAction func quoteTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("/")
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
    
    @IBAction func moreTap(_ sender: AnyObject) {
    }
    
    //*************End Home Keyboard Buttons********************************

    
    
    //*************Alphanumeric Keyboard Buttons********************************
    @IBOutlet var letterArray: Array<UIButton>?
    
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
        proxy.insertText(tempString);
        if (inStoreVariable) {
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
    
    //*************End Alphanumeric Keyboard Buttons********************************
    
    
    //*************Use Variable Display**********************************************
    
    @IBAction func useVariableTap(_ sender: UIButton) {
        let variableListNib = UINib(nibName: "variableList", bundle: nil)
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        let text = proxy.documentContextBeforeInput
        
        var inProxy: [Bool] = []
        
        for variable in variableArray {
            
            if text?.range(of: variable) == nil{
                inProxy.append(false)
            } else {
                inProxy.append(true)
            }
        }
        
        keyboardView = variableListNib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(keyboardView)
        
        var i = 0
        for object in collectionOfButtons! {
            if (i >= variableArray.count) {
                break;
            }
            
            object.isEnabled = true
            object.setTitle(variableArray[i], for: .normal)
            i += 1
        }
    }
    
    @IBAction func selectVariableTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText((sender.titleLabel?.text!)!)
    }
    
    
    
    
    
    
    
    
    //*************End Use Variable Display******************************************
    
    
    
    //*************Loops Keyboard**************************************************
    @IBAction func forTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("for() {\n\n}")
        proxy.adjustTextPosition(byCharacterOffset: -6)
        
    }
    
    @IBAction func whileTap(_ sender: AnyObject) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("while() {\n\n}")
        proxy.adjustTextPosition(byCharacterOffset: -6)

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
    //*************End Loops Keyboard***********************************************
    
   //*************Library Keyboard**************************************************

    @IBAction func libraryTap(_ sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        let tempString = (sender.titleLabel!.text!)
        proxy.insertText("#include <" + tempString + ">\n")
    }

    @IBAction func otherLibraryTap(_ sender: UIButton) {
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
    
    //Function to check whether user needs to datatype for container or not.
    func dataTypeCheck(proxy: UITextDocumentProxy, type: String){
        let str = proxy.documentContextBeforeInput
        let lastChar = str?[(str?.index(before: (str?.endIndex)!))!]
        if (lastChar == "<") {
            proxy.insertText(type  + "> ")
        } else {
            proxy.insertText(type + " ")
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
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
