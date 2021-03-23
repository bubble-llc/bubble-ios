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
        
        Form{
            VStack(){
                HStack{

                        Image("menu_report")
                            .resizable()
                            .frame(width: 36.0, height: 36.0)
                            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        Text("report")
                            .font(.system(size:40))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black, radius: 3, y:1)
                            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        Image("menu_report")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                           
                    
                }
                .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            Spacer()
            Spacer()
                Spacer()
            if #available(iOS 14.0, *)
            {   Spacer()
                Spacer()
                Spacer()
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
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 400)
                    .foregroundColor(commentBoxPressed ? Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255) : Color.gray)
                    .background(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                    .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                    )
                
            }
            else
            {
                Spacer()
                Spacer()
                Spacer()
                MultilineTextField("Enter report here...", text: self.$report_content)
                    .padding(3)
                    .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                    .background(RoundedRectangle(cornerRadius:5))
                    .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            }
            Spacer()
            Spacer()
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
                //self.presentationMode.wrappedValue.dismiss()
                
            })
            {
                Text("Submit")
                    .fontWeight(.bold)
                    .padding(8)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .background(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                    .cornerRadius(8)
                    .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                    )
                
                
            }
            .buttonStyle(PlainButtonStyle())
            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .alert(isPresented: $submittedAlert)
            {
                Alert(title: Text(""), message: Text("Thank you for your report!"), dismissButton: .default(Text("Close")){
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            }.listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        }.background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            
            
    
    }
}
