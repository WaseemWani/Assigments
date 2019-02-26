import UIKit

//var str = "Hello, playground"

class Sub {
    var str = "hello everyone"
    
    subscript (sub: String) ->Bool{
        if str.contains(sub) {
            return true
            //print("yes")
        }
        else {
            return false
            //print("no")
        }
    }
}
let subObj = Sub()
print(subObj["everyone"])
