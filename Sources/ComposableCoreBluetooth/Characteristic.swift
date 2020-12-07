//
//  Characteristic.swift
//  ComposableCoreBluetooth
//
//  Created by Philipp Gabriel on 15.07.20.
//  Copyright © 2020 Philipp Gabriel. All rights reserved.
//

import Foundation
import CoreBluetooth

public struct Characteristic: Equatable {

    let rawValue: CBCharacteristic?
    
    public let identifier: CBUUID
    public let service: Service
    public let properties: CBCharacteristicProperties
    public var value: Data?
    public var descriptors: [Descriptor]
    public var isNotifying: Bool

    init(from characteristic: CBCharacteristic) {
        rawValue = characteristic
        identifier = characteristic.uuid
        service = Service(from: characteristic.service)
        properties = characteristic.properties
        value = characteristic.value
        descriptors = characteristic.descriptors?.map(Descriptor.init) ?? []
        isNotifying = characteristic.isNotifying
    }
    
    init(
        rawValue: CBCharacteristic?,
        identifier: CBUUID,
        service: Service,
        properties: CBCharacteristicProperties,
        value: Data?,
        descriptors: [Descriptor],
        isNotifying: Bool
    ) {
        self.rawValue = rawValue
        self.identifier = identifier
        self.service = service
        self.properties = properties
        self.value = value
        self.descriptors = descriptors
        self.isNotifying = isNotifying
    }
}

extension Characteristic {
    
    public enum Action: Equatable {
        case didDiscoverDescriptors(Result<[Descriptor], BluetoothError>)
        case didUpdateValue(Result<Data, BluetoothError>)
        case didWriteValue(Result<Data, BluetoothError>)
        case didUpdateNotificationState(Result<Bool, BluetoothError>)
    }
}

extension Characteristic {
    
    public static func mock(
        identifier: CBUUID,
        service: Service,
        properties: CBCharacteristicProperties,
        value: Data?,
        descriptors: [Descriptor],
        isNotifying: Bool
    ) -> Self {
        Self(
            rawValue: nil,
            identifier: identifier,
            service: service,
            properties: properties,
            value: value,
            descriptors: descriptors,
            isNotifying: isNotifying
        )
    }
}

extension Characteristic: Identifiable {
    public var id: CBUUID {
        return identifier
    }
}
