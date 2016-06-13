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

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var productsButton: NSPopUpButton!
  var selectedProduct: Product!
  private var products = [Product]()
  private var overviewViewController: OverviewController!
  private var detailViewController: DetailViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let filePath = NSBundle.mainBundle().pathForResource("Products", ofType: "plist") {
      products = Product.productsList(filePath)
      
      productsButton.removeAllItems()

      for product in products {
        productsButton.addItemWithTitle(product.title)
      }
      selectedProduct = products[0]
      productsButton.selectItemAtIndex(0)
    }
  }

  @IBAction func valueChanged(sender: NSPopUpButton) {
    if let bookTitle = sender.selectedItem?.title, let index = products.indexOf({$0.title == bookTitle}) {
      selectedProduct = products[index]
      overviewViewController.selectedProduct = selectedProduct
      detailViewController.selectedProduct = selectedProduct
    }
  }
  
  override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
    let tabViewController = segue.destinationController as! NSTabViewController
    for controller in tabViewController.childViewControllers {
      if controller.dynamicType == OverviewController.self {
        overviewViewController = controller as! OverviewController
        overviewViewController.selectedProduct = selectedProduct
      } else {
        detailViewController = controller as! DetailViewController
        detailViewController.selectedProduct = selectedProduct

      }
    }
  }

}

