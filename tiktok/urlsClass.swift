//
//  urlsClass.swift
//  tiktok
//
//  Created by Bharat shankar on 19/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import Foundation


let API_ROOT = "http://159.65.157.210:4200/api/v1"

let USERS_LOGIN = API_ROOT + "/users/login"

let CREATE_USER_API = API_ROOT + "/users"

let OTP_API = API_ROOT + "/users/verfiyOTP"

let CREATE_PASSWORD = API_ROOT + "/users/reset-password"

let SEND_COMMENT = API_ROOT + "/comments/"

let DEFAULT_HELPER = DefaultsHelper.init()

let COMMENT_LIKE = API_ROOT  + "/comments/likeComment/"

let VIDEO_UPLOAD_AFTER_RESPONSE = "http://testingmadesimple.org/training_app/api/service/uploadVideo"

let PROGRESS_BAR_NOTIFICATION = "ForProgressBar"

let SHARE_VIDEO = "http://www.testingmadesimple.org/training_app/api/Service/videoShare"

let PROFILE_PAGE = "http://testingmadesimple.org/training_app/api/service/viewprofile"

let EDIT_PROFILE_PAGE = "http://testingmadesimple.org/training_app/api/service/hprofileupdate"

let UPLOAD_PROFILE_PIC = "http://testingmadesimple.org/training_app/api/service/hprofilepic"

let DISPLAY_PROFILE_PIC = "http://testingmadesimple.org/training_app/uploads/profile/"

let DISCOVER_PAGE = "http://testingmadesimple.org/training_app/api/Service/search"

let TEMP_VIDEO_URL = "http://159.65.157.210:4200/uploads/"
    /*"http://68.183.81.213:4200/uploads/compress/"*/
    /*"http://68.183.81.213:4200/uploads/compress/"*/
    /*"http://68.183.81.213:4200/uploads/"*/
    /*"http://34.95.66.228/"*/

let GIF_VIDEO_URL = "http://34.95.66.228/"

let VIDEO_UPLOAD_URL_FIRST = "http://159.65.157.210:4200/api/v1/videos"

let USER_SEARCH_API = "http://testingmadesimple.org/training_app/api/Service/userSearch"

let SONG_SEARCH_API = "http://testingmadesimple.org/training_app/api/Service/songSearch"

let VIDEO_PLAYER_PAUSE = "videoPlayerShouldPause"
