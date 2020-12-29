//
//  ReportView.swift
//  Bubble
//
//  Created by Neil Pasricha on 11/12/20.
//  Copyright © 2020 Bubble. All rights reserved.
//

import SwiftUI
import SlideOverCard

struct ReportView: View{
    
    @State private var commentBoxPressed: Bool = false
    @State private var report_content: String = "Enter report here..."
    @State private var submittedReportAlert = false
    @State private var position = CardPosition.bottom
    @State private var submittedAlert = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View{
        
        Form {
            VStack(){
                Text("Report an issue").font(.system(size:25))
                .foregroundColor(Color.black)
                .italic()
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            if #available(iOS 14.0, *)
            {
                //We are currently allowing there to be trailing spaces after comments, need to auto remove those from the comment
                //object before we actually let it be submitted
                TextEditor(text: self.$report_content)
                    .onTapGesture {
                        if !self.commentBoxPressed{
                            self.report_content = " "
                            self.commentBoxPressed = true
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                    .border(Color.black, width:1)
                    .foregroundColor(commentBoxPressed ? Color.black : Color.gray)
                
            }
            else
            {
                MultilineTextField("Enter report here...", text: self.$report_content)
                    .padding(3)
                    .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                    .background(RoundedRectangle(cornerRadius:5))
            }
            Button(action:
            {
                let defaults = UserDefaults.standard
                let username = defaults.string(forKey: defaultsKeys.username)!
                let report_object: [String: Any]  =
                    [
                        "username": username,
                        "content": self.report_content,
                    ]
                //API().submitComment(submitted: commentObject)
                self.submittedAlert = true
                self.presentationMode.wrappedValue.dismiss()
                
            })
            {
                Text("Submit")
            }.alert(isPresented: $submittedAlert){
                Alert(title: Text("Report submitted"), message: Text("Thank you, we appreciate your feedback!"), dismissButton: .default(Text("Close")))
            }
        }
        .foregroundColor(Color.blue) 
    
    }
}
