import UIKit

var str = "Hello, this is Exercise 5"
print(str)
print("\n-------------------------------------------\n")
//:##   Exercise 5
//:   Question1. What is extension?

//:   Extension as the word itselft indicates to extend something. In swift extensions are used to add some functionality to an already existing class structure.It can add computed properties, new functions,new initializers to a class, or structure.

//:  Question2. Create a class and write the delegate of UITextField in extension of that class.
class ModifiedTextField: UITextField {
    
    override func awakeFromNib() {
        delegate = self
    }
}
extension ModifiedTextField : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldEmptyError(value: false)
        
    }
    func fieldEmptyError(value: Bool){
    }
}

//:  Question3. Write a protocol and create an extension of the protocol. In extension create a function

protocol GreetPerson{
    func greet() -> String
}

class Person1 {
    var name: String
    init(name: String) {
        self.name = name
    }
}

extension Person1: GreetPerson {
    func greet() -> String{
        return("Hello")
    }
    func displayName() {
//         let greeting = greet()
//         print("\(greeting)"+" "+"\(name)")
        print(greet()+" "+"\(name)")
    }
}

var objC = Person1(name: "Waseem")
print(" Answer to Question  3. Extension of a protocol")
print("\n-----------------------------------------------------\n")
objC.displayName()



//:  Question 4.Write an enum and create an extension of the enum.

enum Planet: String {
    case mercury, venus, earth, mars, jupitor, uranus, neptune
}

extension Planet {
    
    func isYourPlanet() -> String {
        switch self {
        case .earth:
                 return ("life exists on this planet, it is the planet you live on")
        default:
                return ("life does not exist on this planet, it is not the planet on which live ")
    }
}
}
print("\n-------------------------------------------\n")
print(" Question 4. extension on enum")
print("\n-------------------------------------------\n")
print(Planet.earth.isYourPlanet())
print(Planet.venus.isYourPlanet())

//:  Question 5. What is Generic?

//:   Ans. Generic enables us to write flexible, reusable function which can operate on different types of data. using genereic duplication of writing same code again and again for different types of data can be avoided.


//: Question 6. Explain generic with an example?
// Demonstration. The below written generic function can swap two values of different types - int, string
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

// generic function operating on Int tyoe Values
var oneInt = 2
var anotherInt = 3
swapTwoValues(&oneInt, &anotherInt)
print("\n-------------------------------------------\n")
print(" Question 6. Generics Example: swaping two integer values")
print(oneInt)
print(anotherInt)
print("\n-------------------------------------------\n")

// generic function operating on strings
var oneStr = "hello!"
var anotherStr =  "waseem"
print("swaping two string values")
print("\n-------------------------------------------\n")


// ("swaping two integer values")
swapTwoValues(&oneStr, &anotherStr)
print(oneStr)
print(anotherStr)
print("\n-------------------------------------------\n")

//:  Question 7. Explain the difference between map and compactMap with an example.

//:  map and connectmap both are higher order functions in swift. Map is used to iterarte over a collection like aray, set or dictionary and perfoms same operation on each elemment of the collection. compactMap is same as map function. the onnly difference is that connectMap can handle the optionalas. since an optional can have nil value,connectMap can filter out the nil values.
// demonstration of map and connectMap

var numberArray = [1,2,3,4,5]
// traditional way of the operation
var doubledArray:[Int] = []
for element in numberArray {
    doubledArray.append(element * 2)
}
print(" Answer to Question  7. Example of map and compactMap function")
print("\n-----------------------------------------------------\n")
print("using traditional looping method\n\(doubledArray)")


// performing above operation using map fucntion
var doubledArray1 = numberArray.map({(value: Int) -> Int in
    return value * 2
} )
print("\n-----------------------------------------------------\n")
print("using map function\n\(doubledArray1)")


// using compactMap function, does same task as map functiion
var array2 = numberArray.compactMap({(value: Int) ->Int in
     return value * 2
} )
print("\n-----------------------------------------------------\n")
print("using compactMap function\n \(array2)")


// compactMap handles optionals and filters out nil values...
var stringArray: [String?] = ["waseem","aiman",nil, "umair", nil]
var validNames = stringArray.compactMap({$0})

print("\n-----------------------------------------------------\n")
print("printing only valid names using compactMap \n \(validNames)")
print("\n-----------------------------------------------------\n")


//: Question 8. Write an example of reduce function with initial value 1000.

let result    = numberArray.reduce(1000) {(total, newElement) in (total+newElement)}
print(" Answer to Question  8. Example of reduce function with an initial value 1000, on anarray of 5 elements")
print("\n-----------------------------------------------------\n")
print(result)
print("\n-----------------------------------------------------\n")



//:  Question 9. Create a structure containing name and age of a person, use filter function to find all employees having age more than 25 years.

// creating a structure containing name and age of a person
struct Person {

    var name : String
    var age : Int
}


let person1 = Person(name: "Samir", age: 23)

let person2 = Person(name: "John", age: 30)

let person3 = Person(name: "Rayees", age: 27)

let person4 = Person(name: "Luqman", age: 20)


let personArray = [person1, person2, person3, person4]

//Finding all person whose age is more than 25 using filter function.
var filteredArray: [Person] = personArray.filter({$0.age > 25})
print(" Answer to Question 9. People havinh age more than 25")
print("\n-----------------------------------------------------\n")
print (filteredArray)

print("\n*********************************************\n")
print( "\t\t Thank You 😊" )
print("\n*********************************************\n")
