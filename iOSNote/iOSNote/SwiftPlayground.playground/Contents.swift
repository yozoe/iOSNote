//: Playground - noun: a place where people can play

import UIKit



print(123)

let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
view.backgroundColor = UIColor.red


for _ in 0..<10 {
    print("hehe")
}

print(123)

let url = NSURL(string: "http://www.baidu.com")
print(url)


let name = "wd"
let age = 19
let height = 1.87

let info = "my name is \(name) , my age is, my height is "


let array = ["a", "b", "C"]

var array1 = [String]()

array1.append("hehe")


var hehe:String? = nil
hehe = "haa"
//print(hehe)

var abc = hehe

//print(abc)

var label = UILabel()

label.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)

label.text = "1"

print(label.text)


//let url = NSURL(string: "http://www.baidu.com")
//print(url)


func sum(_: Int, b: Int) {
//    print(a+b)
}

//sum(a: 1, b: 2)
sum(1, b: 2)

func makeCoffee(coffeName: String = "雀巢") -> String {
    return "制作了一杯\(coffeName)咖啡"
}

makeCoffee(coffeName: "拿铁")
makeCoffee()

func sum1(num: Int...) -> Int {
    var result = 0
    for n in num {
        result += n
    }
    return result
}



sum1(num: 10,20,30)



var m = 20
var n = 30

//func swapNum( m:Int, n: Int) {
//    var m = m
//    var n = n
//    let temp = m
//    m = n
//    n = temp
//}

func swapNum( m:inout Int, n: inout Int) {
    var m = m
    var n = n
    let temp = m
    m = n
    n = temp

}

swap(&m, &n)

//print(m)
//print(n)



func test() {
    func demo() {
        print("demo")
    }
    
    print("test")
    
    demo()
}

//test()


class Person : NSObject {
    var age: Int = 0
}

let p = Person()
p.age = 20

p.setValuesForKeys(["age" : 18])


class Student: NSObject {
    var age: Int = 0
    var name: String?
    var mathScore: Double = 0.0
    var chineseScore: Double = 0.0
    
    // 定义计算属性
    var averageScore: Double {
        return (mathScore + chineseScore) * 0.5
    }
    
//    func average() -> Double {
//        return (mathScore + chineseScore) * 0.5
//    }
    
    static var courseCount: Int = 0
    
    override init() {
        
    }
    
    init(dict: [String: AnyObject]) {
        let tempName = dict["name"]
        let tempAge = dict["age"]
        
        name = tempName as? String
//        age = tempAge as! Int
        
        let tempAge1 = tempAge as? Int
        
        if tempAge1 != nil {
            age = tempAge1!
        }
    }
}

let stu = Student(dict: ["name":"dw" as AnyObject])
//stu.age = 10
//stu.name = "yz"
//stu.mathScore = 78
//stu.chineseScore = 59 

print(stu.age)

if let name = stu.name {
    print(name)
}

let averageScore = stu.averageScore

let courseCount = Student.courseCount


class Person1 : NSObject {
    
    var name: String? {
        
        willSet {
            print("will set")
            print(newValue)
        }
        
        didSet {
            print("did set")
        }
    }
}


let p1 = Person1()
p1.name = "hehe"
p1.name = "hehe1"  

