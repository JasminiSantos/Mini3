//
//  CloudKitService.swift
//  Nano3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/10/23.
//

import Foundation
import CloudKit
import SwiftUI

class CloudKitService {
    private let container: CKContainer
    private let database: CKDatabase
    
    init(containerIdentifier: String = "iCloud.group.ADA.Mini3") {
        self.container = CKContainer(identifier: containerIdentifier)
        self.database = container.privateCloudDatabase
    }
    
    func fetchUserID(completion: @escaping (Result<String, Error>) -> Void) {
        container.fetchUserRecordID { (recordID, error) in
            DispatchQueue.main.async {
                if let userID = recordID?.recordName {
                    completion(.success(userID))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func saveObject(recordType: String, objectData: [String: CKRecordValue], completion: @escaping (Error?) -> Void) {
        let newRecord = CKRecord(recordType: recordType)
        for (key, value) in objectData {
            newRecord[key] = value
        }
        database.save(newRecord) { (_, error) in
            completion(error)
        }
    }
    func fetchRecords(recordType: String, predicate: NSPredicate = NSPredicate(value: true), completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let query = CKQuery(recordType: recordType, predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, error) in
            completion(records, error)
        }
    }


    func deleteRecords(recordType: String, key: String, value: String, completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(format: "\(key) == %@", value)
        let query = CKQuery(recordType: recordType, predicate: predicate)

        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records, error == nil else {
                completion(error)
                return
            }
            
            let recordIDsToDelete = records.map { $0.recordID }
            
            let modifyOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDsToDelete)
            modifyOperation.modifyRecordsCompletionBlock = { _, _, error in
                completion(error)
            }
            self.database.add(modifyOperation)
        }
    }
    
    func fetchRecordByID(recordType: String, recordID: UUID, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        let ckRecordID = CKRecord.ID(recordName: recordID.uuidString)
        
        database.fetch(withRecordID: ckRecordID) { (record, error) in
            completion(record, error)
        }
    }
    
    func updateRecord(recordType: String, key: String, recordID: UUID, updatedData: [String: CKRecordValue], completion: @escaping (Error?) -> Void) {

        let ckRecordID = CKRecord.ID(recordName: recordID.uuidString)

        let predicate = NSPredicate(format: "\(key) == %@", recordID.uuidString)

        fetchRecords(recordType: recordType, predicate: predicate) { records, error in
            if let error = error {
                completion(error)
                return
            }

            guard let record = records?.first else {
                let noRecordError = NSError(domain: "YourAppDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "Record not found using CKQuery"])
                completion(noRecordError)
                return
            }
            
            for (key, value) in updatedData {
                record[key] = value
            }

            self.database.save(record) { (_, error) in
                completion(error)
            }
        }
    }
}

extension CloudKitService {
    
    // Generic save method
    func save(record: CKRecord, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        database.save(record) { savedRecord, error in
            DispatchQueue.main.async {
                if let savedRecord = savedRecord {
                    completion(.success(savedRecord))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchRecord(withID recordID: CKRecord.ID, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        database.fetch(withRecordID: recordID) { record, error in
            DispatchQueue.main.async {
                if let record = record {
                    completion(.success(record))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func createReference(from parentRecord: CKRecord, to childRecord: CKRecord, withKey key: String) {
        let reference = CKRecord.Reference(recordID: parentRecord.recordID, action: .deleteSelf)
        childRecord[key] = reference
    }
    
    func update(record: CKRecord, withData data: [String: CKRecordValue], completion: @escaping (Error?) -> Void) {
        for (key, value) in data {
            record[key] = value
        }
        
        save(record: record, completion: { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }
    
    func delete(recordID: CKRecord.ID, completion: @escaping (Error?) -> Void) {
        database.delete(withRecordID: recordID) { _, error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}
