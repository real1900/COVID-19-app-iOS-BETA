//
//  ContactEventExpiryHandler.swift
//  CoLocate
//
//  Created by NHSX.
//  Copyright © 2020 NHSX. All rights reserved.
//

import UIKit

class ContactEventExpiryHandler {
    private let contactEventRepository: ContactEventRepository
    
    init(notificationCenter: NotificationCenter, contactEventRepository: ContactEventRepository) {
        self.contactEventRepository = contactEventRepository
        notificationCenter.addObserver(self, selector: #selector(significantTimeDidChange), name: UIApplication.significantTimeChangeNotification, object: nil)
        significantTimeDidChange()
    }
    
    @objc private func significantTimeDidChange() {
        let ttl = convertDaysIntoSeconds(days: 28)
        contactEventRepository.removeExpiredContactEvents(ttl: ttl)
    }
    
    func convertDaysIntoSeconds(days: Double) -> Double {
        return days * 24 * 60 * 60
    }
}
