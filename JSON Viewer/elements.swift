import Result


typealias ElementKey = String
typealias ElementValue = AnyObject
typealias Element = (ElementKey, ElementValue)


struct ElementNotFoundError: ErrorType {
    var description:String = "Element not found"
}


func defineElements(elements: Element...) -> Array<Element> {
    return elements
}


func el(elements: Array<Element>, key: ElementKey?=nil, idx: Int?=nil) -> ElementValue {
    if key != nil {
        let e = elements.indexOf { key == $0.0 }
        return elements[e!].1
    }
    
    return elements[idx!].1
}