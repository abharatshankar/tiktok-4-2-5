//
//  abuseViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 09/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class abuseViewController: UIViewController {

    var selectedOption = ""
    
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!

    
    @IBOutlet weak var sexContent: UIButton!
    
    @IBOutlet weak var abusiveLang: UIButton!
    
    @IBOutlet weak var abusiveVisual: UIButton!
    
    @IBOutlet weak var religiousContent: UIButton!
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       pageSetup()
        
        //to hide middle camera button
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MiddlebTnHide"), object: nil, userInfo: nil)

        // to set theme color of navigationbar
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        
       
    }
    
    func pageSetup()  {
        
        self.title = "Rate This Video"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        
        self.sexContent.layer.borderColor = UIColor.gray.cgColor
        self.abusiveLang.layer.borderColor = UIColor.gray.cgColor
        self.abusiveVisual.layer.borderColor = UIColor.gray.cgColor
        self.religiousContent.layer.borderColor = UIColor.gray.cgColor
        
        
        self.sexContent.layer.borderWidth = 0.5
        self.abusiveLang.layer.borderWidth = 0.5
        self.abusiveVisual.layer.borderWidth = 0.5
        self.religiousContent.layer.borderWidth = 0.5
        
        self.submitBtn.layer.cornerRadius = 15
        
        
        // for menu burger icon
        let burgerBtn = UIButton(type: UIButton.ButtonType.custom)
        burgerBtn.setImage(UIImage(named:"previous-back-36"), for: UIControl.State())
        burgerBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let burgerBtnItem = UIBarButtonItem(customView: burgerBtn)
        let width1 = burgerBtnItem.customView?.widthAnchor.constraint(equalToConstant: 22)
        width1?.isActive = true
        let height1 = burgerBtnItem.customView?.heightAnchor.constraint(equalToConstant: 22)
        height1!.isActive = true
        navigationItem.leftBarButtonItems = [burgerBtnItem]
        
        
        
    }
    
    @objc func buttonAction()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func star1Action(_ sender: Any) {
        self.star1.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star2.setImage(UIImage(named: "empty-star"), for: .normal)
        self.star3.setImage(UIImage(named: "empty-star"), for: .normal)
        self.star4.setImage(UIImage(named: "empty-star"), for: .normal)
        self.star5.setImage(UIImage(named: "empty-star"), for: .normal)
        //empty-star
        //star-filled
    }
    
    @IBAction func star2Action(_ sender: Any) {
        self.star1.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star2.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star3.setImage(UIImage(named: "empty-star"), for: .normal)
        self.star4.setImage(UIImage(named: "empty-star"), for: .normal)
        self.star5.setImage(UIImage(named: "empty-star"), for: .normal)
    }
    
    @IBAction func star3Action(_ sender: Any) {
        self.star1.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star2.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star3.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star4.setImage(UIImage(named: "empty-star"), for: .normal)
        self.star5.setImage(UIImage(named: "empty-star"), for: .normal)
    }
    
    @IBAction func star4Action(_ sender: Any) {
        self.star1.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star2.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star3.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star4.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star5.setImage(UIImage(named: "empty-star"), for: .normal)
    }
    
    @IBAction func star5Action(_ sender: Any) {
        self.star1.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star2.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star3.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star4.setImage(UIImage(named: "star-filled"), for: .normal)
        self.star5.setImage(UIImage(named: "star-filled"), for: .normal)
    }
    
    
    
    @IBAction func sexualContentAction(_ sender: Any) {
        
        
        self.sexContent.backgroundColor = UIColor.orange
        self.abusiveLang.backgroundColor = UIColor.white
        self.abusiveVisual.backgroundColor = UIColor.white
        self.religiousContent.backgroundColor = UIColor.white
        
        self.sexContent.backgroundColor = UIColor.orange
        self.sexContent.titleLabel?.textColor = UIColor.white
        self.abusiveLang.titleLabel?.textColor = UIColor.gray
        self.abusiveVisual.titleLabel?.textColor = UIColor.gray
        self.religiousContent.titleLabel?.textColor = UIColor.gray
        
        
        
        self.sexContent.layer.borderColor = UIColor.orange.cgColor
        self.abusiveLang.layer.borderColor = UIColor.gray.cgColor
        self.abusiveVisual.layer.borderColor = UIColor.gray.cgColor
        self.religiousContent.layer.borderColor = UIColor.gray.cgColor
        
        
        self.sexContent.layer.borderWidth = 0.5
        self.abusiveLang.layer.borderWidth = 0.5
        self.abusiveVisual.layer.borderWidth = 0.5
        self.religiousContent.layer.borderWidth = 0.5
        
    }
    
    @IBAction func abusiveLanguageAction(_ sender: Any) {
        
        self.sexContent.backgroundColor = UIColor.white
        self.abusiveLang.backgroundColor = UIColor.orange
        self.abusiveVisual.backgroundColor = UIColor.white
        self.religiousContent.backgroundColor = UIColor.white
        
        self.sexContent.titleLabel?.textColor = UIColor.gray
        self.abusiveLang.titleLabel?.textColor = UIColor.white
        self.abusiveVisual.titleLabel?.textColor = UIColor.gray
        self.religiousContent.titleLabel?.textColor = UIColor.gray
        
        
        self.sexContent.layer.borderColor = UIColor.gray.cgColor
        self.abusiveLang.layer.borderColor = UIColor.orange.cgColor
        self.abusiveVisual.layer.borderColor = UIColor.gray.cgColor
        self.religiousContent.layer.borderColor = UIColor.gray.cgColor
        
        
        self.sexContent.layer.borderWidth = 0.5
        self.abusiveLang.layer.borderWidth = 0.5
        self.abusiveVisual.layer.borderWidth = 0.5
        self.religiousContent.layer.borderWidth = 0.5
        
    }
    
    @IBAction func abusiveVisual(_ sender: Any) {
        
        self.sexContent.backgroundColor = UIColor.white
        self.abusiveLang.backgroundColor = UIColor.white
        self.abusiveVisual.backgroundColor = UIColor.orange
        self.religiousContent.backgroundColor = UIColor.white
        
        self.abusiveVisual.backgroundColor = UIColor.orange
        self.sexContent.titleLabel?.textColor = UIColor.gray
        self.abusiveLang.titleLabel?.textColor = UIColor.gray
        self.abusiveVisual.titleLabel?.textColor = UIColor.white
        self.religiousContent.titleLabel?.textColor = UIColor.gray
        
        self.sexContent.layer.borderColor = UIColor.gray.cgColor
        self.abusiveLang.layer.borderColor = UIColor.gray.cgColor
        self.abusiveVisual.layer.borderColor = UIColor.orange.cgColor
        self.religiousContent.layer.borderColor = UIColor.gray.cgColor
        
        
        self.sexContent.layer.borderWidth = 0.5
        self.abusiveLang.layer.borderWidth = 0.5
        self.abusiveVisual.layer.borderWidth = 0.5
        self.religiousContent.layer.borderWidth = 0.5
        
    }
    
    @IBAction func religiousContent(_ sender: Any) {
        
        self.sexContent.backgroundColor = UIColor.white
        self.abusiveLang.backgroundColor = UIColor.white
        self.abusiveVisual.backgroundColor = UIColor.white
        self.religiousContent.backgroundColor = UIColor.orange
        
        self.religiousContent.backgroundColor = UIColor.orange
        self.sexContent.titleLabel?.textColor = UIColor.gray
        self.abusiveLang.titleLabel?.textColor = UIColor.gray
        self.abusiveVisual.titleLabel?.textColor = UIColor.gray
        self.religiousContent.titleLabel?.textColor = UIColor.white
        
        self.sexContent.layer.borderColor = UIColor.gray.cgColor
        self.abusiveLang.layer.borderColor = UIColor.gray.cgColor
        self.abusiveVisual.layer.borderColor = UIColor.gray.cgColor
        self.religiousContent.layer.borderColor = UIColor.orange.cgColor
        
        
        self.sexContent.layer.borderWidth = 0.5
        self.abusiveLang.layer.borderWidth = 0.5
        self.abusiveVisual.layer.borderWidth = 0.5
        self.religiousContent.layer.borderWidth = 0.5
    }
    
    
    
    
    @IBAction func submitAction(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
