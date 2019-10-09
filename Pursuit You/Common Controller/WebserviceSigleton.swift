
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
        
        let headers = ["Content-Type": "application/x-www-form-urlencoded","Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImM4ZjQxN2ViZGJiZWM1NTQ2ZTgxZjAwNzA3MWExZjJkYzM3MGUwN2IxMjhlNTllOWEzZWYwMGY3NzYxYTBlNzM3NmUzOWZiMmVlZjFjMDczIn0.eyJhdWQiOiIxIiwianRpIjoiYzhmNDE3ZWJkYmJlYzU1NDZlODFmMDA3MDcxYTFmMmRjMzcwZTA3YjEyOGU1OWU5YTNlZjAwZjc3NjFhMGU3Mzc2ZTM5ZmIyZWVmMWMwNzMiLCJpYXQiOjE1NzAwODA3NTgsIm5iZiI6MTU3MDA4MDc1OCwiZXhwIjoxNjAxNzAzMTU4LCJzdWIiOiIyMiIsInNjb3BlcyI6W119.Kk5shxJUi6OwSak-oaRm65lekM6YHE2m0r2__Spb6TzlT-nahxKkR2KKEl3cbcN4f4ywFigS2Qs3CbuMEBE97cyDENt5oygzIWxud1XwZmExtgy_2ReuM3ISrTRKWBtMfEnEQ9ykHzTrdlQ6M9U7o2rC-scHOca6nzqogSbJa839xztLsApRJs6SCfOgH_9ApG-vyRxTh1qtwg_abMZMbf5huB_R-MEzOTnmoua7WzonSC9umgqrvi51cBoh3tJFDOy2hFfDBOYubBERMc0weQEUB9UvXgm7mMAkUU0VpVgcLvTus9ABpWq9dalRgXKqS73BfXXm4Il4ufkHu5oAsXrJg9R2pf1ZKjEIFaOY8KjgbDf3VzlFUr4OM_2zFojaYsS4rC5U68bn-dg-lrPMqS0IbXKn5c3ydOK_-doQKJwcA3fUaM7EuAMxRrb8LpQNTyVkLSmjX1w8ImdpE0Yg82--5R1QdEcUWN9l3SdpuTPIEJV_ixMINccgDpbhHDHv7w-5kZ5F4dbsvgtDNe9XobS5pfWwQtDRwloJcSJsj4UdGBjO79noSc2LOVDE2G6MLwNJ28eb64KVVnxf6nieuAvzpYjIjUwcy-Q7bo8Ic1LMqFtHMXf9vXkG8uMIOgQKd8gcyetPBnc7CwR0vp0ZP4E13wPoddQZZ4_LIj7S1UQ"]
        
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
