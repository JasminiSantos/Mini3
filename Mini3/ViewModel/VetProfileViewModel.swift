//
//  VetProfileViewModel.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 07/11/23.
//

import SwiftUI
import PencilKit
import CloudKit

class VetProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var crmv: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var cpf: String = ""
    @Published var signatureImage: UIImage? = nil
    @Published var veterinarian: Veterinarian? = nil
    
    @Published var activeAlert: AlertType?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var isSuccess: Bool = false
    @Published var isLoading: Bool = false
    @Published var requestInProgress: Bool = false
    @Published var accountExists: Bool = false
    
    @Published var showiCloudAlert = false
    @Published var navigateToMenuView = false
    
    @Published var isChecked = false
    @Published var navigateToConditions = false
    
    @Published var viewState: ViewState = .loading
    
    private let recordType = "Doctor"
    let cloudKitService = CloudKitService()
    
    func createDoctorData() {
        guard validateInput() else {
            print("Invalid input.")
            return
        }
        
        guard let image = signatureImage, let imageData = image.pngData() else {
            return
        }
        
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        do {
            try imageData.write(to: fileURL)
        } catch {
            print("Error writing image data to temp file: \(error)")
            return
        }
        
        let signatureAsset = CKAsset(fileURL: fileURL)
        cloudKitService.fetchUserID { result in
            
        }
        let veterinarian = Veterinarian(id: UUID(), name: name, email: email, crmv: crmv, cpf: cpf, phoneNumber: phone, signatureUrl: "signatureUrl")
        
        let doctorData: [String: CKRecordValue] = [
            "id": veterinarian.id.uuidString as CKRecordValue,
            "name": name as CKRecordValue,
            "crmv": crmv as CKRecordValue,
            "phone": phone as CKRecordValue,
            "email": email as CKRecordValue,
            "cpf": cpf as CKRecordValue,
            "signature": signatureAsset
        ]
        
        let recordType = "Doctor"
        cloudKitService.saveObject(recordType: recordType, objectData: doctorData) { error in
            try? FileManager.default.removeItem(at: fileURL)
            
            if let error = error {
                print("There was an error saving the doctor account: \(error)")
            } else {
                print("Doctor account created successfully!")
                self.navigateToMenuView = true
            }
        }
    }
    
    func fetchDoctorData() {
            guard let id = veterinarian?.id else {
                print("Veterinarian ID is nil.")
                return
            }
            
            cloudKitService.fetchRecordByID(recordType: recordType, recordID: id) { [weak self] record, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error fetching doctor data: \(error)")
                    } else if let record = record, let asset = record["signature"] as? CKAsset {
                        self?.name = record["name"] as? String ?? ""
                        self?.crmv = record["crmv"] as? String ?? ""
                        self?.phone = record["phone"] as? String ?? ""
                        self?.email = record["email"] as? String ?? ""
                        self?.cpf = record["cpf"] as? String ?? ""
                        
                        if let fileURL = asset.fileURL {
                            do {
                                let imageData = try Data(contentsOf: fileURL)
                                self?.signatureImage = UIImage(data: imageData)
                            } catch {
                                print("Error loading image data: \(error)")
                            }
                        }
                    }
                }
            }
        }
    
    func fetchDoctors(completion: @escaping (Bool) -> Void) {
        cloudKitService.fetchRecords(recordType: recordType) { [weak self] records, error in
            DispatchQueue.main.async {
                if let records = records {
                    let result = records.compactMap { record -> Veterinarian? in
                        if let id = record["id"] as? String,
                           let name = record["name"] as? String,
                           let crmv = record["crmv"] as? String,
                           let phone = record["phone"] as? String,
                           let email = record["email"] as? String,
                           let cpf = record["cpf"] as? String,
                           let asset = record["signature"] as? CKAsset,
                           let fileURL = asset.fileURL {
                            do {
                                let imageData = try Data(contentsOf: fileURL)
                                self?.signatureImage = UIImage(data: imageData)
                            } catch {
                                print("Error loading image data: \(error)")
                            }
                            return Veterinarian(id: UUID(uuidString: id)!, name: name, email: email, crmv: crmv, cpf: cpf, phoneNumber: phone, signatureUrl: fileURL.path)
                        } else {
                            print("Failed to process record: \(record)")
                            return nil
                        }
                    }
                    self?.veterinarian = result.first
//                    self?.isLoading = false
//                    self?.viewState = self?.veterinarian != nil ? .menu : .vetProfile
                    completion(self?.veterinarian != nil)
                } else if let error = error {
//                    self?.isLoading = false
                    print("Error fetching doctor from iCloud: \(error.localizedDescription)")
                    self?.viewState = .iCloudError
                    completion(false)
                } else {
//                    self?.isLoading = false
//                    self?.viewState = .vetProfile
                    completion(false)
                }
            }
        }
    }

    func showiCloudError() {
        activeAlert = .iCloudError
        showiCloudAlert = true
    }

    func showValidationError(message: String) {
        activeAlert = .validationError(message)
    }

    func checkiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] (accountStatus, error) in
            DispatchQueue.main.async {
                switch accountStatus {
                case .available:
                    self?.checkIfUserAccountExists()
                case .noAccount, .restricted, .couldNotDetermine, .temporarilyUnavailable:
                    self?.viewState = .iCloudError
                    self?.showiCloudError()
                @unknown default:
                    self?.viewState = .iCloudError
                    self?.showiCloudError()
                }
            }
        }
    }


    
    func checkIfUserAccountExists() {
        fetchDoctors { [weak self] userAccountExists in
            DispatchQueue.main.async {
                self?.viewState = userAccountExists ? .menu : .vetProfile
            }
        }
    }
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func validateInput() -> Bool {
        return !name.isEmpty && !crmv.isEmpty && !phone.isEmpty && !email.isEmpty && !cpf.isEmpty && signatureImage != nil
    }
}


enum AlertType {
    case iCloudError
    case validationError(String)
    case customError(String)

    var message: String {
        switch self {
        case .iCloudError:
            return "iCloud account is not available."
        case .validationError(let message):
            return message
        case .customError(let message):
            return message
        }
    }
}

enum ViewState {
    case loading
    case menu
    case vetProfile
    case conditions
    case iCloudError
}
