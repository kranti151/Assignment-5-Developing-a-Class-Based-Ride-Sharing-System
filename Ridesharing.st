
"1. Abstract Base Class: Ride"
Object subclass: #Ride
	instanceVariableNames: 'rideID pickupLocation dropoffLocation distance fare'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RideSharing'.

!Ride methodsFor: 'initializing'!
initializeWith: anID pickup: p dropoff: d distance: dist
	rideID := anID.
	pickupLocation := p.
	dropoffLocation := d.
	distance := dist.
	fare := self calculateFare.
! !

!Ride methodsFor: 'calculations'!
calculateFare
	"Default fare calculation: base rate 1.5 per mile"
	^ distance * 1.5
! !

!Ride methodsFor: 'accessing'!
fare
	^ fare
! !

!Ride methodsFor: 'accessing'!
rideDetails
	^ 'RideID: ' , rideID , ' | From: ' , pickupLocation , ' -> To: ' , dropoffLocation , ' | Distance: ' , distance displayString , ' mi | Fare: $' , fare displayString
! !

"2. Concrete Class: StandardRide"
Ride subclass: #StandardRide
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RideSharing'.

!StandardRide methodsFor: 'calculations'!
calculateFare
	"Standard fare: $2.00 base + $1.50 per mile"
	^ (distance * 1.5) + 2.0
! !

"3. Concrete Class: PremiumRide"
Ride subclass: #PremiumRide
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RideSharing'.

!PremiumRide methodsFor: 'calculations'!
calculateFare
	"Premium fare: $5.00 base + $3.00 per mile"
	^ (distance * 3.0) + 5.0
! !

"4. Driver Class"
Object subclass: #Driver
	instanceVariableNames: 'driverID name rating assignedRides'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RideSharing'.

!Driver methodsFor: 'initializing'!
initializeWith: anID name: n rating: r
	driverID := anID.
	name := n.
	rating := r.
	assignedRides := OrderedCollection new.
! !

!Driver methodsFor: 'managing rides'!
addRide: aRide
	assignedRides add: aRide
! !

!Driver methodsFor: 'accessing'!
getDriverInfo
	Transcript show: 'DriverID: ' , driverID , ' | Name: ' , name , ' | Rating: ' , rating displayString; cr.
	Transcript show: 'Assigned rides (' , assignedRides size displayString , '):'; cr.
	assignedRides do: [:r | Transcript show: (r rideDetails); cr]
! !

"5. Rider Class"
Object subclass: #Rider
	instanceVariableNames: 'riderID name requestedRides'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'RideSharing'.

!Rider methodsFor: 'initializing'!
initializeWith: anID name: n
	riderID := anID.
	name := n.
	requestedRides := OrderedCollection new.
! !

!Rider methodsFor: 'managing rides'!
requestRide: aRide
	requestedRides add: aRide
! !

!Rider methodsFor: 'accessing'!
viewRides
	Transcript show: 'RiderID: ' , riderID , ' | Name: ' , name; cr.
	Transcript show: 'Requested rides (' , requestedRides size displayString , '):'; cr.
	requestedRides do: [:r | Transcript show: (r rideDetails); cr]
! !

"----------------------------------------------------------------------"
"                     Simulation Script (Main)                           "
"----------------------------------------------------------------------"
| r1 r2 r3 d1 d2 u1 u2 rides total |

"Ride Initialization (Polymorphism Example)"
r1 := StandardRide new.
r1 initializeWith: 'R100' pickup: 'Downtown' dropoff: 'Airport' distance: 10.5.
r2 := PremiumRide new.
r2 initializeWith: 'R101' pickup: 'Mall' dropoff: 'University' distance: 6.2.
r3 := StandardRide new.
r3 initializeWith: 'R102' pickup: 'Home' dropoff: 'Office' distance: 3.4.

rides := OrderedCollection with: r1 with: r2 with: r3.

"Display All Rides (Demonstrates rideDetails and fare polymorphism)"
Transcript show: '-- All Rides (polymorphic fare & details) --'; cr.
rides do: [:r | Transcript show: (r rideDetails); cr].
Transcript cr.

"Driver Initialization and Ride Assignment"
d1 := Driver new.
d1 initializeWith: 'D200' name: 'Alice' rating: 4.9.
d1 addRide: r1.
d1 addRide: r3.

d2 := Driver new.
d2 initializeWith: 'D201' name: 'Bob' rating: 4.7.
d2 addRide: r2.

"Rider Initialization and Ride Requests"
u1 := Rider new.
u1 initializeWith: 'U300' name: 'Charlie'.
u1 requestRide: r1.
u1 requestRide: r3.

u2 := Rider new.
u2 initializeWith: 'U301' name: 'Dana'.
u2 requestRide: r2.

"Display Driver Info"
Transcript show: '-- Driver Info --'; cr.
d1 getDriverInfo.
Transcript cr.
d2 getDriverInfo.
Transcript cr.

"Display Rider Info"
Transcript show: '-- Rider Info --'; cr.
u1 viewRides.
Transcript cr.
u2 viewRides.
Transcript cr.

"Calculate Total Fares (Demonstrates fare polymorphism in a loop)"
total := 0.
rides do: [:r | total := total + (r fare)].
Transcript show: 'Total fares: $' , total displayString; cr.
!
