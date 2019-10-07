
import Foundation
import Alamofire

class WebserviceSigleton {

    // MARK:-- POST  Request Method
    //To POST data from Remote resource.Returns NSDictionary Object
    
    private let baseUrl = Configurator.baseURL
    static let shared = WebserviceSigleton()
    
    
    func POSTServiceWithParameters(urlString : String , params : Dictionary<String, AnyObject> , callback:@escaping ( _ data: Dictionary<String, AnyObject>?,  _ error: NSError? ) -> Void)  {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.session.configuration.timeoutIntervalForResource = 120
        
        let url =  "\(baseUrl)\(urlString)"
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
       // let headers = ["Content-Type": "application/json"]
        
        print("Request POST URL:\(url) PARAMS:\(params) HEADER: ")
        
        manager.request(url, method: .post, parameters: params, encoding:  URLEncoding.default, headers: headers).responseJSON { response in
            
            
            print(response)
            
            guard response.result.error == nil else {
                print("Error for POST :\(urlString):\(response.result.error!)")
                callback(nil , response.result.error! as NSError? )
                return
            }
            
            if let value = response.result.value {
                print("JSON: \(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    print("Response for POST in DICTIONARY :\(urlString):\(value)")
                    callback(result , nil )
                }
            }
        }
}
 
    
    //GET SERVICE
    func GETServiceWithParameters(urlString : String , params : Dictionary<String, AnyObject> , callback:@escaping ( _ data: Dictionary<String, AnyObject>?,  _ error: NSError? ) -> Void)  {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.session.configuration.timeoutIntervalForResource = 120
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        print("Request POST URL:\(urlString) PARAMS:\(params) HEADER: ")
        
        manager.request(urlString, method: .get, parameters: params, encoding:  URLEncoding.default, headers: headers).responseJSON { response in
            print(response)
            guard response.result.error == nil else {
                print("Error for POST :\(urlString):\(response.result.error!)")
                callback(nil , response.result.error! as NSError? )
                return
            }
            
            if let value = response.result.value {
                print("JSON: \(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    print("Response for POST in DICTIONARY :\(urlString):\(value)")
                    callback(result , nil )
                }
            }
        }
    }
    
    func GETService(urlString : String , callback:@escaping ( _ data: Dictionary<String, AnyObject>?,  _ error: NSError? ) -> Void)  {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.session.configuration.timeoutIntervalForResource = 120
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded","Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI3ZDNhZjMyMjlhNmY3YWYwNWQ1N2IxMzFiY2MxNTA0MzgyNTJmN2Q2NGFmMzg0YTQyMWExOWNhZGNmYWQyNTdiODU4YWU1NDc0MzE4ZTI3In0.eyJhdWQiOiIxIiwianRpIjoiYjdkM2FmMzIyOWE2ZjdhZjA1ZDU3YjEzMWJjYzE1MDQzODI1MmY3ZDY0YWYzODRhNDIxYTE5Y2FkY2ZhZDI1N2I4NThhZTU0NzQzMThlMjciLCJpYXQiOjE1NzAwNzg2MzEsIm5iZiI6MTU3MDA3ODYzMSwiZXhwIjoxNjAxNzAxMDMxLCJzdWIiOiIzMCIsInNjb3BlcyI6W119.xm4XhnoCTj9YLAMA9WeXYJ2CsbzoSswx56fR_pIbQmxJlrBqxugkXlHt8U1ylLzbarUD0FLfUUi-rGCu83Y-3veEguoLHmtY70nK4CfhzRmYCUDgrA-3_AYVsEKhV9qz0vrCM5Idw03uFkVLVlIGW_ShIaiHFiful-eR7F4hn1P73sFfGEvCl3s_EfIZGmrKeq9BeqqE5tNHU3CqE4JNnvEOR_g4YnWiYBEawbmm0O-scPFX-1NeBObmlXhdApLYp7_3T0BkzD8aPSwkEKFwc_qz56YHIY-_pv3b3rvomqF4kdfmOODuWL_tssbHn-Jw4E3dxmdTzxWCO1ztSCcIihzfdrfU0DXtdn7OvymZ-kyGGvM8q8ZXe0TA2szOYIr_iU6kLkZ_RYy4wBw0wNGAqOPGcd4bTHcESxZczGolGNR-iPBuKcun7BczmwWmHzDSVRT4T0B85R-r65vhpDC7VA1mIEei2vCAU_9FBNnVWO5qTyyK7xzbkP5UmL2BZKfRC5YyxFwOpcm11ZvISrJVlooV7sa47UTlV8bLCX1tFLHsl4qQe5YXhIklj8P4ScEIv_uZE8k_NNpz4DvlFIJqZ-g_tQMVv3l4GzJSEa7A2Q-Bry4YErJYwER7IniomQOoNDiJL5WNpOT5F4ONDb276fIzduYQG9c5ZFT4b3-tIoI"]
        
        let url =  "\(baseUrl)\(urlString)"
        
        print("Request POST URL:\(url) HEADER: ")
        
        manager.request(url, method: .get, parameters: nil , encoding:  URLEncoding.default, headers: headers).responseJSON { response in
            print(response)
            guard response.result.error == nil else {
                print("Error for POST :\(urlString):\(response.result.error!)")
                callback(nil , response.result.error! as NSError? )
                return
            }
            
            if let value = response.result.value {
                print("JSON: \(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    print("Response for POST in DICTIONARY :\(urlString):\(value)")
                    callback(result , nil )
                }
            }
        }
    }
 
    //MARK:- ELITE MATCH
    func POSTServiceWithParameters_Elite(urlString : String , params : Dictionary<String, AnyObject> , callback:@escaping ( _ data: Dictionary<String, AnyObject>?,  _ error: NSError? ) -> Void)  {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.session.configuration.timeoutIntervalForResource = 120
        
        let url =  "\(Configurator.baseURL)\(urlString)"
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        print("Request POST URL:\(url) PARAMS:\(params) HEADER: ")
        
        manager.request(url, method: .get, parameters: params, encoding:  URLEncoding.default, headers: headers).responseJSON { response in
            
            print(response)
            
            guard response.result.error == nil else {
                print("Error for POST :\(urlString):\(response.result.error!)")
                callback(nil , response.result.error! as NSError? )
                return
            }
            
            if let value = response.result.value {
                print("JSON: \(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    print("Response for POST in DICTIONARY :\(urlString):\(value)")
                    callback(result , nil )
                }
            }
        }
    }
    
    
    func POSTServiceWithParameters_EliteTEST(urlString : String , params : Dictionary<String, AnyObject> , callback:@escaping ( _ data: Dictionary<String, AnyObject>?,  _ error: NSError? ) -> Void)  {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.session.configuration.timeoutIntervalForResource = 120
        
        let headers = ["Content-Type": "application/json"]
        
        print("Request POST URL:\(urlString) PARAMS:\(params) HEADER: ")
        
        manager.request(urlString, method: .post , parameters: params, encoding:  URLEncoding.default, headers: nil).responseJSON { response in
            
            print(response)
            
            guard response.result.error == nil else {
                print("Error for POST :\(urlString):\(response.result.error!)")
                callback(nil , response.result.error! as NSError? )
                return
            }
            
            if let value = response.result.value {
                print("JSON: \(value)")
                if let result = value as? Dictionary<String, AnyObject> {
                    print("Response for POST in DICTIONARY :\(urlString):\(value)")
                    callback(result , nil )
                }
            }
        }
    }
    
    
//    func webservice_getDropDownData(){
//        
//        WebserviceSigleton().GETServiceWithParameters(urlString: Configurator.baseURL + Configurator.baseURL , params: [:] as! Dictionary<String, AnyObject> , callback: { (result,error) -> Void in
//            if result != nil {
//                let response = result! as Dictionary
//                
//                //clean all array
//                constantVC.arrDropDown_Match.arrLangaugeDropDown.removeAll()
//                constantVC.arrDropDown_Match.arrReligionDropDown.removeAll()
//                constantVC.arrDropDown_Match.arrEducationDropDown.removeAll()
//                constantVC.arrDropDown_Match.arrLifeStyle.removeAll()
//                constantVC.arrDropDown_Match.arrFavMusic.removeAll()
//                constantVC.arrDropDown_Match.arrFavFood.removeAll()
//                constantVC.arrDropDown_Match.arrZoadicSign.removeAll()
//                constantVC.arrDropDown_Match.arrTravel.removeAll()
//                constantVC.arrDropDown_Match.arrFavDessert.removeAll()
//                
//                //language
//                if let Arrlangauges = response["languages"] as? NSArray {
//                    
//                    for item in Arrlangauges  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrLangaugeDropDown.append(name)
//                    }
//                }
//                
//                //religion
//                if let ArrReligion = response["religions"] as? NSArray {
//                    
//                    for item in ArrReligion  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrReligionDropDown.append(name)
//                    }
//                }
//                
//                //education
//                if let ArrEducation = response["Education"] as? NSArray {
//                    
//                    for item in ArrEducation  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrEducationDropDown.append(name)
//                    }
//                }
//                
//                //ethincity
//                if let ArrEducation = response["ethincity"] as? NSArray {
//                    
//                    for item in ArrEducation  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrEducationDropDown.append(name)
//                    }
//                }
//                
//                
//                //lifeStyle
//                if let ArrLifeStyle = response["LifeStyle"] as? NSArray {
//                    
//                    for item in ArrLifeStyle  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrLifeStyle.append(name)
//                    }
//                }
//                
//                //favorite music
//                if let ArrFavMusic = response["favmusic"] as? NSArray {
//                    
//                    for item in ArrFavMusic  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrFavMusic.append(name)
//                    }
//                }
//                
//                //favorite food
//                if let ArrFavFood = response["favfood"] as? NSArray {
//                    
//                    for item in ArrFavFood  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrFavFood.append(name)
//                    }
//                }
//                
//                //zoadiac sign
//                if let ArrZoadicSign = response["favzoadic"] as? NSArray {
//                    
//                    for item in ArrZoadicSign  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrZoadicSign.append(name)
//                    }
//                }
//                //travel
//                if let ArrTravel = response["travellocation"] as? NSArray {
//                    
//                    for item in ArrTravel  {
//                        let dic = item as! NSDictionary
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrTravel.append(name)
//                    }
//                }
//                //favorite dessert
//                if let ArrDessert = response["favdessert"] as? NSArray {
//                      print(ArrDessert)
//                    for item in ArrDessert  {
//                        let dic = item as! NSDictionary
//                        print(dic)
//                        
//                        var name:String = ""
//                        if let name_ = dic["name"] as? String {
//                            print("name>>",name)
//                            name = name_
//                        }
//                        constantVC.arrDropDown_Match.arrFavDessert.append(name)
//                    }
//                }
//            }
//        })
//        
//    }
//    
    
    //MARK:- CALL LOGS (VOICE /VIDEO)
    func call_toUpdateVoice_OR_VideoCall_status(duration:String , status:String , logID: String , sid:String)
    {
        /*var idToSend = ""
        var param = ""
        
        if logID == "" { //voice
            param = "sid"
            idToSend = sid
        }
        else { //video
            param = "logid"
            idToSend = logID
        }
        
        let Url: String = "\(constantVC.GeneralConstants.BASE_IP)updateVideoLog"
        let params = ["status" : status,
                      "duration" : duration,
                      param: idToSend]
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(Url , method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                }
                break
                
            case .failure(_):
                print(response.result.description)
                break
            }
        }*/
    }
    
    
    func addCallLog(senderID:String , senderNo:String , receiverNo:String , sessionID: String , membersID:String , isGroup:String , isAudio:String , dialogID:String , GroupName: String , duration:String , callState:String , groupPhoto:String)
    {
        
       /* let Url: String = "\(constantVC.GeneralConstants.BASE_IP)\(constantVC.WebserviceName.URL_ADD_CALL_LOG)"
        let params = ["senderID" : senderID,
                      "senderNo" : senderNo,
                      "receiverNo" : receiverNo,
                      "sessionID" : sessionID,
                      "membersID" : membersID,
                      "isGroup" : isGroup,
                      "isAudio" : isAudio,
                      "dialogID" : dialogID,
                      "GroupName" : GroupName,
                      "duration" : duration ,
                      "callState" : callState,
                      "groupPhoto" : groupPhoto]
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(Url , method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                }
                break
                
            case .failure(_):
                print(response.result.description)
                break
            }
        }*/
    }
}

//MARK:- Internet Connectivity
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        
        return NetworkReachabilityManager()!.isReachable
    }
}
