//
//  CloudKitService.swift
//  Nano3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/10/23.
//

import Foundation
import CloudKit

class CloudKitService {
    private let container: CKContainer
    private let database: CKDatabase
    
    init(containerIdentifier: String = "iCloud.com.ADA.Nano3") {
        self.container = CKContainer(identifier: containerIdentifier)
        self.database = container.privateCloudDatabase
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
