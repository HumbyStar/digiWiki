//
//  AddEditViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 12/12/22.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var ivFirstImage: UIImageView!
    @IBOutlet weak var ivSecondImage: UIImageView!
    @IBOutlet weak var tfDescript: UITextField!
    
    //var digimonAbout: [Digimon] = []
    var digimon: Digimon!
    var miniIMGbt: Bool = false
    var backgroundIMG: Bool = false
    var ages: [String] = ["Rookie", "Champion","Ultimate","Perfect"]
    
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatToolbar()
    }
    
    func formatToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = .blue
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        toolbar.items = [btCancel,btFlexible, btDone]
        
        tfAge.inputView = pickerView
        tfAge.inputAccessoryView = toolbar
    }
    
    @objc func done () {
        tfAge.text = ages[pickerView.selectedRow(inComponent: 0)]
        
        cancel()
    }
    
    @objc func cancel() {
        tfAge.resignFirstResponder()
    }
    
    @IBAction func AddGame(_ sender: UIButton) {
        //MARK: Vou precisar adaptar o projeto para CoreData, ja que no formato json não fica da melhor forma.
        
        if digimon == nil {
            digimon = Digimon(context: context)
        }
        digimon.name = tfName.text
        digimon.descript = tfDescript.text
        digimon.firstIMG = ivFirstImage.image
        digimon.miniIMG = ivSecondImage.image
        if !tfAge.text!.isEmpty {
            digimon.age = ages[pickerView.selectedRow(inComponent: 0)]
        }
        
        do {
           try context.save()
        }catch {
            print (error)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addSecondImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Adicionar Imagem", message: "Qual local deseja buscar a imagem?", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Album de fotos", style: .default) { (action: UIAlertAction) in
            self.selectedImage(sourceType: .photoLibrary)
            self.miniIMGbt = true
        }
        alert.addAction(libraryAction)
        
        let pictureAction = UIAlertAction(title: "Galeria de Fotos", style: .default) { (action: UIAlertAction) in
            self.selectedImage(sourceType: .savedPhotosAlbum)
            self.miniIMGbt = true
        }
        alert.addAction(pictureAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func selectedImage(sourceType: UIImagePickerController.SourceType) {
        let imagePicker =  UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
    }
    
    @IBAction func addBackgroundImage(_ sender: UIButton) {
        let alert =  UIAlertController(title: "Adicionar Imagem", message: "Qual local deseja buscar?", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Galeria de fotos", style: .default) { (action: UIAlertAction) in
            self.selectedImage(sourceType: .photoLibrary)
            self.backgroundIMG = true
        }
        alert.addAction(libraryAction)
        
        let pictureAction = UIAlertAction(title: "Album de Fotos", style: .default) { (Action: UIAlertAction) in
            self.selectedImage(sourceType: .savedPhotosAlbum)
            self.backgroundIMG = true
        }
        alert.addAction(pictureAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

extension AddEditViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return ages[row]
    }
}

extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if miniIMGbt == true {
            let image = info [UIImagePickerController.InfoKey.originalImage] as! UIImage
            ivSecondImage.image = image
            miniIMGbt = false
            dismiss(animated: true)
        }
        
        if backgroundIMG == true {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            ivFirstImage.image = image
            backgroundIMG = false
            dismiss(animated: true)
        }
    }
}
