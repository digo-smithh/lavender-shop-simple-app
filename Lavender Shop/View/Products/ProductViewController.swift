//
//  ProductsViewController.swift
//  Lavender Shop
//
//  Created by Rodrigo Smith Rodrigues on 20/07/22.
//

import UIKit

class ProductViewController: UIViewController, UITextFieldDelegate {
    
    var productView: UIView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>?
    var productViewModel = ProductViewModel()
    let nameTextField: UITextField = UITextField()
    let amountTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        amountTextField.delegate = self
        setup()
    }
    
    func setup() {
        view.backgroundColor = Constants.defaultBackColor
        addMainLabel()
        addPageLabel()
        addLabels()
        addTextFields()
        addButton()
        setupListView()
    }
    
    func addMainLabel(){
        let label = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: 30))
        label.textAlignment = .center
        label.text = "Lavender Shop"
        label.font = UIFont(name: "American Typewriter", size: 26.0)
        label.textColor = Constants.defaultColor
        label.center.x = self.view.center.x
        self.view.addSubview(label)
    }
    
    func addPageLabel(){
        let label = UILabel(frame: CGRect(x: 0, y: 80, width: 300, height: 30))
        label.textAlignment = .center
        label.text = "Add product"
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textColor = .darkGray
        label.center.x = self.view.center.x
        self.view.addSubview(label)
    }
    
    func addLabels() {
        addNameLabel()
        addAmountLabel()
    }
    
    func addNameLabel() {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 30, y: 150, width: 100, height: 21)
        label.textColor = Constants.defaultColor
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.textAlignment = .left
        label.text = "Name"
        self.view.addSubview(label)
    }
    
    func addAmountLabel() {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 30, y: 200, width: 100, height: 21)
        label.textColor = Constants.defaultColor
        label.font = UIFont(name: "Helvetica", size: 16.0)
        label.textAlignment = .left
        label.text = "Amount"
        self.view.addSubview(label)
    }
    
    func addTextFields() {
        addNameTextField()
        addAmountTextField()
    }
    
    func addNameTextField() {
        nameTextField.frame = CGRect(x: 90, y: 146, width: 240, height: 30)
        nameTextField.layer.cornerRadius = 5
        nameTextField.backgroundColor = .white
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(2, 0, 0)
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        nameTextField.adjustsFontSizeToFitWidth = true
        self.view.addSubview(nameTextField)
    }
    
    func addAmountTextField() {
        amountTextField.frame = CGRect(x: 105, y: 196, width: 120, height: 30)
        amountTextField.layer.cornerRadius = 5
        amountTextField.backgroundColor = .white
        amountTextField.layer.sublayerTransform = CATransform3DMakeTranslation(2, 0, 0)
        amountTextField.font = UIFont.systemFont(ofSize: 20)
        amountTextField.adjustsFontSizeToFitWidth = true
        amountTextField.keyboardType = .numberPad
        self.view.addSubview(amountTextField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = "1234567890"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: typedCharacterSet)
        }
    
    
    func addButton() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 230, y: 200, width: 100, height: 20)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(Constants.defaultColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        
        
        button.setOnClickListener {
            guard let name = self.nameTextField.text else { return }
            guard let amount = self.amountTextField.text else { return }
            self.productViewModel.appendProduct(Product(name: name, amount: Int(amount)!))
            
            self.populate(with: self.productViewModel.products)
        }
        
        self.view.addSubview(button)
    }
    
    func setupListView() {
        let listView = ListView()
        
        listView.frame = CGRect(x: 0, y: view.frame.height / 3, width: view.frame.width, height: view.frame.height / 1.5)
        
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Product> {
            cell, indexPath, product in
            
            var content = cell.defaultContentConfiguration()
            content.text = product.name
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Product>(collectionView: listView.collectionView) {
            collectionView, indexPath, product in
            
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: product)
        }
        
        view.addSubview(listView)
    }
    
    func populate(with products: [Product]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products)
        dataSource?.apply(snapshot)
    }
}

extension ProductViewController{
    enum Section {
        case main
    }
}


