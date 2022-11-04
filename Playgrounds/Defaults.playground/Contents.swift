import UIKit

let defaults = UserDefaults.standard

defaults.set(2.5, forKey: "Volume")
let volume = defaults.float(forKey: "Volume")

defaults.set(Date(), forKey: "AppDate")
let udata = defaults.object(forKey: "AppDate")

let dictionary = ["name": "Anna"]
defaults.set(dictionary, forKey: "dict")
let myDict = defaults.dictionary(forKey: "dict")
