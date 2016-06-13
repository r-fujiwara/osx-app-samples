/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import AppKit

struct Product {
  let title: String
  let audience: String
  let descriptionText: String
  let price: NSNumber
  var image: NSImage? {
    get {
      let i = NSImage(named: imageName)
      
      return i
    }
  }
  
  private let imageName: String
  
  static func productsList(fileName: String) -> [Product] {
    //1
    var products = [Product]()
    //2
    if let productList = NSArray(contentsOfFile: fileName) as? [NSDictionary] {
      //3
      for dict in productList {
        //4
        let product = Product(dictionary: dict)
        products.append(product)
      }
    }
    //5
    return products
  }
  
  init(dictionary: NSDictionary) {
    title = dictionary.objectForKey("Name") as! String
    audience = dictionary.objectForKey("Audience") as! String
    descriptionText = dictionary.objectForKey("Description") as! String
    price = dictionary.objectForKey("Price") as! NSNumber
    imageName = dictionary.objectForKey("Imagename") as! String
  }
}
