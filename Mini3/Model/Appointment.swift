//
//  Appointment.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import SwiftUI

class Appointment: ObservableObject, Identifiable, Codable {
    let id = UUID()
    @Published var date: String
    @Published var time: String
    @Published var weight: Double
    @Published var bodyCondition: String
    @Published var reasonForVisit: String
    @Published var observations: String
    @Published var treatment: String
    
    init(date: String, time: String, weight: Double, bodyCondition: String, reasonForVisit: String, observations: String, treatment: String) {
        self.date = date
        self.time = time
        self.weight = weight
        self.bodyCondition = bodyCondition
        self.reasonForVisit = reasonForVisit
        self.observations = observations
        self.treatment = treatment
    }
    
    enum CodingKeys: CodingKey {
        case id, date, time, weight, bodyCondition, reasonForVisit, observations, treatment
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try container.decode(String.self, forKey: .date)
        time = try container.decode(String.self, forKey: .time)
        weight = try container.decode(Double.self, forKey: .weight)
        bodyCondition = try container.decode(String.self, forKey: .bodyCondition)
        reasonForVisit = try container.decode(String.self, forKey: .reasonForVisit)
        observations = try container.decode(String.self, forKey: .observations)
        treatment = try container.decode(String.self, forKey: .treatment)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(time, forKey: .time)
        try container.encode(weight, forKey: .weight)
        try container.encode(bodyCondition, forKey: .bodyCondition)
        try container.encode(reasonForVisit, forKey: .reasonForVisit)
        try container.encode(observations, forKey: .observations)
        try container.encode(treatment, forKey: .treatment)
    }
}

import CloudKit

extension Appointment {
    var asCKRecord: CKRecord {
        let record = CKRecord(recordType: "Appointment")
        record.setValue(id.uuidString, forKey: "id")
        record.setValue(date, forKey: "date")
        record.setValue(time, forKey: "time")
        record.setValue(weight, forKey: "weight")
        record.setValue(bodyCondition, forKey: "bodyCondition")
        record.setValue(reasonForVisit, forKey: "reasonForVisit")
        record.setValue(observations, forKey: "observations")
        record.setValue(treatment, forKey: "treatment")

        return record
    }
}
