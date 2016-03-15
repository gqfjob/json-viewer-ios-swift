import Alamofire
import BrightFutures
import JASON
import Result


func fetch(url: String) -> Future<JSON, FutureJSONError> {
    return Alamofire
        .request(.GET, url)
        .futureJSON()
}
