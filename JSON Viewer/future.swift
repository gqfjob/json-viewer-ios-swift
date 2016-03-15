import Alamofire
import BrightFutures
import JASON
import Result


struct FutureJSONError: ErrorType {
    var description: String
}


extension Alamofire.Request {
    
    func futureJSON() -> Future<JSON, FutureJSONError> {
        let promise = Promise<JSON, FutureJSONError>()
        
        responseString { response in
            switch response.result {
                case .Success:
                    let json = JSON(response.result.value!)
                    promise.success( json )
                case .Failure(let error):
                    promise.failure( FutureJSONError(description: error.description) )
            }
        }
        
        return promise.future
    }
    
}