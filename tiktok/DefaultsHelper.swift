//
//  DefaultHelper.swift
//  Touchless
//
//  Created by Martijn De Bruijn on 06-11-17.
//  Copyright © 2017 Inventief-it. All rights reserved.
//

import Foundation


class DefaultsHelper{
    
    var preferences:UserDefaults!
    
    init(){
         preferences = UserDefaults.standard
    }
    
    
    func getSecret() -> String{
        if let secret = preferences.object(forKey: "secret") as? String{
            if secret != "" {
                return preferences.string(forKey: "secret")!
            }
        }
        //big else
//        self.signUpWithDevice()
        return ""
    }
    
    func setSecret(_ secret:String){
        preferences.set(secret, forKey: "secret")
        preferences.synchronize()
    }
    
    
    func setLoginInfo(_ jsonString:String){
        preferences.set(jsonString, forKey: "logininfo")
        preferences.set(false, forKey: "deviceloggedin")
        preferences.synchronize()
    }
    
    func getLoginInfo()->String{
        if let _ = preferences.object(forKey: "logininfo"){
            return preferences.string(forKey: "logininfo")!
        }else{
            return ""
        }
    }
    
    
    
    
    func setAuthKeyInfo(_ jsonString:String){
        preferences.set(jsonString, forKey: "AuthKeyInfo")
       
        preferences.synchronize()
    }
    
    func getAuthKeyInfo()->String{
        if let _ = preferences.object(forKey: "AuthKeyInfo"){
            return preferences.string(forKey: "AuthKeyInfo")!
        }else{
            return ""
        }
    }
    
    
    
    
    func setAuthKey(_ jsonString:String){
        preferences.set(jsonString, forKey: "AuthKey")
        
        preferences.synchronize()
    }
    
    func getAuthKey()->String{
        if let _ = preferences.object(forKey: "AuthKey"){
            return preferences.string(forKey: "AuthKey")!
        }else{
            return ""
        }
    }
    
    
    
    func setUserNameInfo(_ jsonString:String){
        preferences.set(jsonString, forKey: "UserNameInfo")
        
        preferences.synchronize()
    }
    
    func getUserNameInfo()->String{
        if let _ = preferences.object(forKey: "UserNameInfo"){
            return preferences.string(forKey: "UserNameInfo")!
        }else{
            return ""
        }
    }
    
    
    
    func setMobileNumberInfo(_ jsonString:String){
        preferences.set(jsonString, forKey: "MobileNumberInfo")
        
        preferences.synchronize()
    }
    
    func getMobileNumberInfo()->String{
        if let _ = preferences.object(forKey: "MobileNumberInfo"){
            return preferences.string(forKey: "MobileNumberInfo")!
        }else{
            return ""
        }
    }
    
    
    func setUserId(_ jsonString:String){
        preferences.set(jsonString, forKey: "UserId")
        
        preferences.synchronize()
    }
    
    func getUserId()->String{
        if let _ = preferences.object(forKey: "UserId"){
            return preferences.string(forKey: "UserId")!
        }else{
            return ""
        }
    }
    
    
    
    func setItemId(_ jsonString:String){
        preferences.set(jsonString, forKey: "ItemId")
        
        preferences.synchronize()
    }
    
    func getItemId()->String{
        if let _ = preferences.object(forKey: "ItemId"){
            return preferences.string(forKey: "ItemId")!
        }else{
            return ""
        }
    }
    
    
    
    func setId(_ jsonString:String){
        preferences.set(jsonString, forKey: "Id")
        
        preferences.synchronize()
    }
    
    func getId()->String{
        if let _ = preferences.object(forKey: "Id"){
            return preferences.string(forKey: "Id")!
        }else{
            return ""
        }
    }
    
    
    func setPassword(_ jsonString:String){
        preferences.set(jsonString, forKey: "Password")
        
        preferences.synchronize()
    }
    
    func getPassword()->String{
        if let _ = preferences.object(forKey: "Password"){
            return preferences.string(forKey: "Password")!
        }else{
            return ""
        }
    }
    
    
    // gootes shipping id
    func setShippingId(_ jsonString:String){
        preferences.set(jsonString, forKey: "Id")
        
        preferences.synchronize()
    }
    
    func getShippingId()->String{
        if let _ = preferences.object(forKey: "Id"){
            return preferences.string(forKey: "Id")!
        }else{
            return ""
        }
    }
    
    //for facebook profile PIC
    func setFbProfilePic(_ picUrl: String )  {
        preferences.set(picUrl, forKey: "fbProfilePic")
        
        preferences.synchronize()
    }
    
    func getFbProfilePic()->String{
        if let _ = preferences.object(forKey: "fbProfilePic"){
            return preferences.string(forKey: "fbProfilePic")!
        }else{
            
            return ""
        }
    }
    
    
    
    // gootes address id
    func setfbId(_ jsonString:String){
        preferences.set(jsonString, forKey: "fbid")
        
        preferences.synchronize()
    }
    
    func getfbId()->String{
        if let _ = preferences.object(forKey: "fbid"){
            return preferences.string(forKey: "fbid")!
        }else{
            return ""
        }
    }
    
    
    
    //username gootes
    func setUserName(_ jsonString:String){
        preferences.set(jsonString, forKey: "username")
        
        preferences.synchronize()
    }
    
    func getUserName()->String{
        if let _ = preferences.object(forKey: "username"){
            return preferences.string(forKey: "username")!
        }else{
            return ""
        }
    }
    
    
    //mobile number gootes
    func setMobileNumber(_ jsonString:String){
        preferences.set(jsonString, forKey: "mobilenumber")
        
        preferences.synchronize()
    }
    
    func getMobileNumber()->String{
        if let _ = preferences.object(forKey: "mobilenumber"){
            return preferences.string(forKey: "mobilenumber")!
        }else{
            return ""
        }
    }
    
    
    
    //email gootes
    func setEmail(_ jsonString:String){
        preferences.set(jsonString, forKey: "email")
        
        preferences.synchronize()
    }
    
    func getEmail()->String{
        if let _ = preferences.object(forKey: "email"){
            return preferences.string(forKey: "email")!
        }else{
            return ""
        }
    }
    
    
    
    
    
    
    
    
    func setUserIdInfo(_ jsonString:String){
        preferences.set(jsonString, forKey: "UserIdInfo")
        
        preferences.synchronize()
    }
    
    func getUserIdInfo()->String{
        if let _ = preferences.object(forKey: "UserIdInfo"){
            return preferences.string(forKey: "UserIdInfo")!
        }else{
            return ""
        }
    }
    
    
    func setSignupInfo(_ jsonString:String){
        preferences.set(jsonString, forKey: "signupInfo")
        preferences.set(false, forKey: "deviceloggedin")
        preferences.synchronize()
    }
    
    func getSignupInfo()->String{
        if let _ = preferences.object(forKey: "signupInfo"){
            return preferences.string(forKey: "signupInfo")!
        }else{
            return ""
        }
    }
    
    func setDeviceloggedIn(_ loggedIn:Bool){
        preferences.set(loggedIn, forKey: "deviceloggedin")
        preferences.synchronize()
    }
    
    func getDeviceLoggedIn() -> Bool{
        if let _ = preferences.object(forKey: "deviceloggedin"){
            return preferences.bool(forKey: "deviceloggedin")
        }else{
            return false
        }
    }
    

    
    
   
}
