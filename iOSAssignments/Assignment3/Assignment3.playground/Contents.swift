
import UIKit
var str = "Hello!, This is Exercise 3"
print (str)

//:##    Exercise 3

//  Initializer Question 1: Implement the parameterised initialisation with class or struct.
class Person {
    var name : String = "waseem"
    var surname : String = "wani"
    var age : Int
    
    init(name: String, surname: String, age: Int){
        self.name = name
        self.surname = surname
        self.age = age
    }
}

let person1 =  Person(name: "waseem", surname: "wani", age: 22)
print("\n-------------------------------------------------------\n")
print(" initializers Question 1 : creating a numeric array \n")
print("name of the person: \(person1.name)")
print("surname:\t\t\t\(person1.surname)")
print("age of the person is: \(person1.age)")


//: Initializer Q2. Write all the Rules of initialiser in Inheritance

//: Swift applies the following three rules for delegation calls between initializers
//: Rule 1
//: A designated initializer must call a designated initializer from its immediate superclass.
//:Rule 2
//:A convenience initializer must call another initializer from the same class.
//:Rule 3
//:A convenience initializer must ultimately call a designated initializer.



//:  Initialzer Question3:  Using convenience Initializers, write-down the Initializers for MOVIE class having basic attributes like title, author, publish_date
class Movie {
    var title : String
    var publishDate : String
    var directorName: String

    init(title : String, publishDate: String, directorName: String){
          self.title = title
          self.publishDate =  publishDate
          self.directorName = directorName
        }
    convenience init ()
    {
        self.init(title: "Dangal", publishDate: "21 dec 2016", directorName: "Nitesh Tiwari")
    }


}
let movei1 = Movie() //     creating an object of Movie Class
print("\n-------------------------------------------------------\n")
print(" initializers Question 3 : creating a numeric array \n")
print("Details of the movie")
print(movei1.title, movei1.directorName, movei1.publishDate)

//: Initializer Question4: Declare a structure which can demonstrate the throwable Initializer


enum ProductError: Error {
    case InvalidProductID
    case invalidPrice
    var description: String {
        switch self {
        case .InvalidProductID:
            return "Invalid product id"
        
        default:
            return "Unable to initialise the object"
        }
    }
}


 struct Product {
    let productID: Int?
    let productDescription: String?
    let productPrice: Double
    
    init?(productID: Int, productDescription: String, productPrice: Double) throws {
        if productID <= 0 {
            throw ProductError.InvalidProductID
        }
        self.productID = productID
        self.productDescription = productDescription
        self.productPrice = productPrice
    }
}
print("-------------------------------------------------------")
print("Question 4. throwable initializer \n")
do {
    let product = try Product(productID: 0 , productDescription: "Television", productPrice: 5000.0)
    print(product as Any)
} catch {
    print( "Error :\(error)")
}



//:   Array Question1: Create an array containing the 5 different integer values. Write are at least 4 ways to do this.

var array1  = [1,2,3,4,5]
print("\n-------------------------------------------------------\n")
print(" Arrays Question 1 : creating a numeric array \n")
print(array1)

// case2 declaration
var array2: [Int] = []
array2 = [8,9,10,11,14]

// case3 array declaration
var array3:  Array<Int> = [10,11,12,13,14,15]


// case4 array declaratio
var array4 = [Int]()
 array4 = [20,21,22,23,26]


//:  Array Question2. Create an immutable array containing 5 city names.
  let cityNames = ["New Delhi","Chandigarh", "Banaras","Lucknow","Agra"]
 //     cityNames[0] = ["Srinagar"]


//: Array Question3. Create an array with city 5 city names. Later add other names like Canada, Switzerland, Spain to the end of the array in at least 2 possible ways

var city = ["New Delhi","Shimla","Ahmedabad","Trivendrum","Gandhnagar","shimla"]
city.append("srinagar")
city.append("Canada")
city.append("Switzerland")
city.append("Spain")



//: Question4. Create an array with values 14, 18, 15, 16, 23, 52, 95. Replace the values 24 & 48 at 2nd & 4th index of array
   var numArray: [Int] = []
   numArray = [ 14, 18, 15, 16, 23, 52, 92 ]
   numArray[2] = 24
   numArray[4] = 48
print("\n-----------------------------------------------\n")
print("\n Array Question 4: \n")
print(numArray)



//:##  Set
//Given the following sets:
let houseAnimals: Set = ["🐱","🐼"]
let farmAnimals: Set = ["🐔", "🐑","🦆", "🐱", "🐼"]
let cityAnimals: Set = ["🐦", "🦅"]

//:  1.Determine whether the set of house animals is a subset of farm animals.
print("\n-----------------------------------------------\n")
print("Set Question 1: check subset of... \n")
print(houseAnimals.isSubset(of: farmAnimals))

//:  2. Determine whether the set of farm animals is a superset of house animals.
print("\n-----------------------------------------------\n")
print("Set Question 2: check superset of... \n")
    print(farmAnimals.isSuperset(of: houseAnimals))

//:  3. Determine if the set of farm animals is disjoint with city animals.
print("\n-----------------------------------------------\n")
print("Set Question 3: check disjoint of... \n")
print(farmAnimals.isDisjoint(with: cityAnimals))

//:   4. Create a set that only contains farm animals that are not also house animals.
let onlyFarmAnimals: Set = farmAnimals.subtracting(houseAnimals)
print("\n-----------------------------------------------\n")
print("Set Question 4: set difference/ subtraction \n")

for member in onlyFarmAnimals{
          print(member)
         }

// print(onlyFarmAnimals)

//: 5. Create a set that contains all the animals from all sets.
print("\n-------------------------------------------------------\n")
print(" Question 5 : create a set that contains all the animals from all sets \n")

let allFarm_HousAnimals: Set = farmAnimals.union(houseAnimals)
let allAnimals: Set = allFarm_HousAnimals.union(cityAnimals)
for member in allAnimals{
      print(member)
}
print("\n-----------------------------------------------\n")
//:## Dictionary
//  Question1. Create an empty dictionary with keys of type String and values of type Int and assign it to a variable in as many ways as you can think of (there's at least 4 ways).
//
//  case1
var emptyDict1 = [String:Int]()

//  case2
var emptyDict2: [String:Int] = [:]

//  case3
 var emptyDict3: Dictionary<String, Int> = [:]

// case4
var emptyDict4 = Dictionary<String, Int>()


//:   Question2. Create a mutable dictionary named secretIdentities where the key value pairs are "Hulk" -> "Bruce Banner", "Batman" -> "Bruce Wayne", and "Superman" -> "Clark Kent".


var secretIdentities: [String:String] = ["Hulk": "Bruce Banner","Batman" : "Bruce Wayne","Superman": "Clark Kent"]

print("\n Dictionary Question 2: creating a dictionary with starting type keys and Inyt Type Values \n")

print(secretIdentities)

print("\n ----------------------------------------------\n")

//  question3. Create a nesters structure of Key-value pair.
var stateCapitals: Dictionary<String,String> = ["uttarakhand":"Dehradun","Punjab":"Chandigarh","Delhi":"New Delhi","Uttar Pradesh":"Lucknow"]

var nestedDictionary: [String: Any] = ["Name": "Waseem","surname":"Wani","A":stateCapitals]

print("\n Dictionary Question 3: Nested Dictionary goes here\n")
print(nestedDictionary)
print("\n-----------------------------------------------\n")

//:  Question 4. Print all the keys in the dictionary
var dictKeys = [String](secretIdentities.keys)

print("\n Dictionary Question 4: Printing the keys of a dictionry\n")

for (key) in dictKeys{
 print(key)
}
print("\n-----------------------------------------------\n")


//:## Subscription
//: Question1. what are subscripts. write down the syntax for subscripts
//:  Ans. subscripts are shortcuts for accessing the member elements of a collection, list, or sequence. we can use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval.

// syntax of subscript

class Subscript {
    subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
        return 0
        }
    set(newValue) {
        // perform a suitable setting action here
    }
 }
}
//:  Question 2. Create a simple subscript that outputs true if a string contains a substring and false otherwise
class DaysOfaWeek {
    private var days = ["Sunday", "Monday", "Tuesday", "Wednesday",
                        "Thursday", "Friday", "saturday"]
    subscript(index: Int) -> Bool {
        get {
            if days[index].contains( "Sunday" ) {
                return true
            }
            else{
                return false
            }
        }
    }
}
var obj = DaysOfaWeek()
print(obj[0])
