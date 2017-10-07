//
//  ViewController.swift
//  iOS DataStorage
//
//  Created by Nisha Raghu on 12/09/17.
//  Copyright © 2017 Nisha Raghu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var bookNameTxtField: UITextField!

    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var SaveArchivesBtn: UIButton!
    @IBOutlet weak var SaveFileStorageBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SaveFileStorageBtn.layer.borderWidth = 0.5
        SaveArchivesBtn.layer.borderWidth = 0.5
    }
    @IBAction func saveToFile(_ sender: Any) {
        let fileName = "SaveToFile"
        let bookName = "Book name:"+(bookNameTxtField.text)!+"\n"
        let author = "Author Name:"+(authorTextField.text)!+"\n"
        let descp = "Description:"+(descriptionText.text)!+"\n"
        let inputString = bookName+author+descp
   
        // Save data to file
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        //filepath
        print("Saving to File...")
        print("Saved to File Storage!!")
        print("FilePath of File Storage: \(fileURL.path)")
        //writing into the file
        do{
            try inputString.write(to: fileURL,atomically:true, encoding: String.Encoding.utf8)
        }
        catch let error  as NSError{
            print (error)
            print("Failed to write in file")
            print (error)
        }
        
        //reading from the file created
        do {
            let text2 = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)
            print("Contents of file:\n"+text2)
        }
        catch let error  as NSError{
            print (error)
            print("Failed to read from file")
            print (error)
        }
    }

    @IBAction func savetoArchives(_ sender: Any) {
        let fileName = "SaveToArchives"
        let bookName = "Book name:"+(bookNameTxtField.text)!+"\n"
        let author = "Author Name:"+(authorTextField.text)!+"\n"
        let descp = "Description:"+(descriptionText.text)!+"\n"
        let inputString = bookName+author+descp
        
        // Save data to file
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        //filepath
        print("Saving..")
        print("Saved to Archives!!")
        print("Path of Archives: \(fileURL.path)")
        
        // write to file
        NSKeyedArchiver.archiveRootObject(inputString, toFile: fileURL.path)
        
        // read from file
        let dict2 = String(describing: NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path))
        print("Contents of Archived File:\n"+dict2)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        descriptionText.borderStyle = UITextBorderStyle.roundedRect
    }
}

