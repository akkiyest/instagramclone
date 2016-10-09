//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by Akihiro Itoh on 2016/09/28.
//  Copyright © 2016年 akihiro.itoh. All rights reserved.
//

import UIKit

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AdobeUXImageEditorViewControllerDelegate {
    @IBAction func handleLibraryButton(sender: AnyObject) {
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            presentViewController(pickerController, animated: true, completion: nil)
            
        }
    }
    @IBAction func handleCameraButton(sender: AnyObject) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func handleCancelButton(sender: AnyObject) {
        // 画面を閉じる
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func photoEditor(editor: AdobeUXImageEditorViewController, finishedWithImage image: UIImage?) {
        // エディタ画面を閉じる
        editor.dismissViewControllerAnimated(true, completion: nil)
        
        // 投稿の画面を開く
        let postViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Post") as! PostViewController
        postViewController.image = image
        presentViewController(postViewController, animated: true, completion: nil)
    }
    
    // AdobeImageEditorで加工をキャンセルしたときに呼ばれる
    func photoEditorCanceled(editor: AdobeUXImageEditorViewController) {
        // エディタ画面を閉じる
        editor.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if info[UIImagePickerControllerOriginalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // ここでpresentViewControllerを呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            dispatch_async(dispatch_get_main_queue()) {
                
                // AdobeImageEditorを起動する
                let adobeViewController = AdobeUXImageEditorViewController(image: image)
                adobeViewController.delegate = self
                self.presentViewController(adobeViewController, animated: true, completion:  nil)
            }
        }
        
        // 閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // 閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
