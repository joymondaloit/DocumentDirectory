//
//  ViewController.swift
//  DocumentDirectoryDemo
//
//  Created by Joy Mondal on 10/09/18.
//  Copyright © 2018 Joy Mondal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createDirectory()
        
        if getInfoFromDocumentDirectory() != "No Image"
        {
            self.imageView.image = UIImage(contentsOfFile: getInfoFromDocumentDirectory())

        }
        else
        {
            insertDataIntoDirectory()
            self.imageView.image = UIImage(contentsOfFile: getInfoFromDocumentDirectory())

        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func createDirectory()
    {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/ImageFolder")
        print(paths)
        if !fileManager.fileExists(atPath: paths)
        {
            do
            {
                try (fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil))
            }
            catch
            {
                print("Error is \(error.localizedDescription)")
            }
        }
        else
        {
            print("Directory already created")
        }
    }
    
    func insertDataIntoDirectory()
    {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/ImageFolder/image.jpg")
        let imgUrlArr = "http://callforphotos.vvmf.org/PhotoEffort/AssociatedImages/Medium/James Aalund.jpg"
        let imageUrl = imgUrlArr.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: imageUrl)
        let data = NSData(contentsOf: url!)
        let image = UIImage(data: data! as Data)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths, contents: imageData! as Data, attributes: nil)
    }
    
    func getInfoFromDocumentDirectory() ->String
    {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/ImageFolder/image.jpg")
        if fileManager.fileExists(atPath: paths)
        {
            return paths
        }
        else
        {
            return "No Image"
        }
        
    }
}

