# Assignment-5-Developing-a-Class-Based-Ride-Sharing-System

## Overview
This project demonstrates the implementation of a **Ride Sharing System** using **object-oriented programming (OOP)** principles in **Smalltalk (Pharo)** and **C++**. The system models a simplified ride-sharing platform, including rides, drivers, and riders. It showcases correct usage of **encapsulation**, **inheritance**, and **polymorphism**.

## Features

### Ride Classes
- **Ride (Base Class):** Stores core ride details: `rideID`, `pickupLocation`, `dropoffLocation`, `distance`, and `fare`.
- **StandardRide & PremiumRide (Subclasses):**  
  - Override the `fare()` method for different pricing strategies.  
  - Demonstrates **polymorphism** when calculating fares for different ride types.  
- **rideDetails():** Displays detailed ride information.

### Driver Class
- **Attributes:** `driverID`, `name`, `rating`, `assignedRides` (private)  
- **Methods:** `addRide()`, `getDriverInfo()`  
- Demonstrates **encapsulation** by restricting direct access to ride history.

### Rider Class
- **Attributes:** `riderID`, `name`, `requestedRides`  
- **Methods:** `requestRide()`, `viewRides()`

### System Functionality
- Stores rides of different types in a collection.  
- Polymorphic fare calculation and ride display for any ride type.  
- Supports driver and rider interaction with ride history.
