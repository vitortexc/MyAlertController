//
//  ViewController.swift
//  Lodjinha-B2W
//
//  Created by Fernanda de Lima on 22/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var categotiaCollectionView: UICollectionView!
    @IBOutlet weak var maisVendidosTableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initView(){
        activityIndicator.center = CGPoint(x: self.tableView.center.x, y: 10)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    private func initTableview(){
        //table configuraçoes
        self.maisVendidosTableView.register(UINib(nibName: "ProdutoViewCell", bundle: nil), forCellReuseIdentifier: "produtoCell")
        
        self.maisVendidosTableView.estimatedRowHeight = 70
        self.maisVendidosTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func initCollection(){
         self.categotiaCollectionView.register((UINib(nibName: "CategoriaViewCell", bundle: nil), forCellWithReuseIdentifier: "categoriaCell")
    }
    
    private func initPageControl(){
        
    }


}

