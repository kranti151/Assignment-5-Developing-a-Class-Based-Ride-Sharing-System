// ridesharing.cpp
#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <iomanip>

using namespace std;

// Base class: Ride
class Ride {
protected:
    string rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance; // miles
public:
    Ride(const string& id, const string& pickup, const string& dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}
    virtual ~Ride() = default;

    // polymorphic fare calculation
    virtual double fare() const {
        // default base rate
        const double baseRatePerMile = 1.5;
        return distance * baseRatePerMile;
    }

    virtual void rideDetails() const {
        cout << fixed << setprecision(2);
        cout << "RideID: " << rideID
             << " | From: " << pickupLocation
             << " -> To: " << dropoffLocation
             << " | Distance: " << distance << " mi"
             << " | Fare: $" << fare() << '\n';
    }

    string getRideID() const { return rideID; }
};

// Derived class: StandardRide
class StandardRide : public Ride {
public:
    StandardRide(const string& id, const string& pickup, const string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}
    double fare() const override {
        const double perMile = 1.5; // standard
        const double baseFee = 2.0;
        return distance * perMile + baseFee;
    }
};

// Derived class: PremiumRide
class PremiumRide : public Ride {
public:
    PremiumRide(const string& id, const string& pickup, const string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}
    double fare() const override {
        const double perMile = 3.0; // premium
        const double serviceFee = 5.0;
        return distance * perMile + serviceFee;
    }
};

// Driver class
class Driver {
private:
    string driverID;
    string name;
    double rating;
    // encapsulated assignedRides (private)
    vector<shared_ptr<Ride>> assignedRides;

public:
    Driver(const string& id, const string& name_, double rating_)
        : driverID(id), name(name_), rating(rating_) {}

    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "DriverID: " << driverID << " | Name: " << name << " | Rating: " << rating << '\n';
        cout << "Assigned rides (" << assignedRides.size() << "):\n";
        for (const auto& r : assignedRides) {
            r->rideDetails();
        }
    }

    string getName() const { return name; }
};

// Rider class
class Rider {
private:
    string riderID;
    string name;
    vector<shared_ptr<Ride>> requestedRides;

public:
    Rider(const string& id, const string& name_) : riderID(id), name(name_) {}

    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "RiderID: " << riderID << " | Name: " << name << '\n';
        cout << "Requested rides (" << requestedRides.size() << "):\n";
        for (const auto& r : requestedRides) {
            r->rideDetails();
        }
    }
};

// Demonstrate system functionality
int main() {
    cout << "=== Ride Sharing System (C++) Demo ===\n\n";

    // create rides polymorphically
    vector<shared_ptr<Ride>> rides;
    rides.push_back(make_shared<StandardRide>("R100", "Downtown", "Airport", 10.5));
    rides.push_back(make_shared<PremiumRide>("R101", "Mall", "University", 6.2));
    rides.push_back(make_shared<StandardRide>("R102", "Home", "Office", 3.4));
    rides.push_back(make_shared<PremiumRide>("R103", "Station", "Hotel", 12.0));

    // Show polymorphic fare() and details
    cout << "-- All Rides (polymorphic calls) --\n";
    for (const auto& r : rides) {
        r->rideDetails(); // virtual dispatch calls subclass fare()
    }
    cout << '\n';

    // drivers
    Driver d1("D200", "Alice", 4.9);
    Driver d2("D201", "Bob", 4.7);

    // riders
    Rider rider1("U300", "Charlie");
    Rider rider2("U301", "Dana");

    // Assign rides and simulate requests
    d1.addRide(rides[0]);
    d1.addRide(rides[2]);
    d2.addRide(rides[1]);
    d2.addRide(rides[3]);

    rider1.requestRide(rides[0]);
    rider2.requestRide(rides[1]);
    rider1.requestRide(rides[2]);

    cout << "-- Driver Info --\n";
    d1.getDriverInfo();
    cout << '\n';
    d2.getDriverInfo();
    cout << '\n';

    cout << "-- Rider Info --\n";
    rider1.viewRides();
    cout << '\n';
    rider2.viewRides();
    cout << '\n';

    // Demonstrate storing different ride types in a single collection and calling fare()
    cout << "-- Polymorphism demo: compute total fares from mixed collection --\n";
    double total = 0.0;
    for (const auto& r : rides) {
        total += r->fare(); // virtual
    }
    cout << "Total of fares for all rides: $" << fixed << setprecision(2) << total << '\n';

    cout << "\n=== End of Demo ===\n";
    return 0;
}
