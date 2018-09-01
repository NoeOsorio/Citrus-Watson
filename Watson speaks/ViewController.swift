//
//  ViewController.swift
//  Watson speaks
//
//  Created by Noe Osorio on 30/08/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//
import AssistantV1
import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var inputText: UITextField!
    @IBOutlet var outputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func assistant(text:String) -> String{
        let username = "11c79bfa-6a04-4877-9d57-6805b86b9841"
        let password = "8JqIbYKaY3Fs"
        let workspace = "b67416dd-ec00-4710-96c5-b7ef618e5e0d"
        // instantiate service
        let assistant = Assistant(username: username, password: password, version: "2018-09-01")
        var responseMsg = ""
        // start a conversation
        assistant.message(workspaceID: workspace) { response in
            print("Conversation ID: \(response.context.conversationID!)")
            print("Response: \(response.output.text.joined())")
            
            // continue assistant
            print("Request: \(text)")
            let input = InputData(text: text)
            let request = MessageRequest(input: input, context: response.context)
            assistant.message(workspaceID: workspace, request: request) { response in
                //print("Response: \(response.output.text.joined())")
                responseMsg = response.output.text.joined()
                
            }
            
        }
        return responseMsg
    }
    
    @IBAction func send(_ sender: Any) {
        var inputTextString = inputText.text!
        var outputTextString = assistant(text: inputTextString)
        outputText.text = outputTextString
    }
    
}

