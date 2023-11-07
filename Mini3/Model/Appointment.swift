//
//  Appointment.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 02/11/23.
//

import Foundation

struct Appointment: Codable {
    var date: String
    var time: String
    var weight: Double
    var bodyCondition: String
    var reasonForVisit: String
    var observations: String
    var treatment: String
}

class AppointmentModel: ObservableObject {
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
}
