import T "../types/types";
import OrderedMap "mo:base/OrderedMap";
import Nat "mo:base/Nat";

// add lastName to the contact map
module ContactMigration {

  // our migration function
  public func migration(old : {
    // define the old type
      var contactMap : OrderedMap.Map<Nat, T.Contact>;
    }) : {
      // define the new type
      var contactMap : OrderedMap.Map<Nat, T.Contact_v1>;
    } {
    // create a new map
    let natMap = OrderedMap.Make<Nat>(Nat.compare);
    var newcontactMap : OrderedMap.Map<Nat, T.Contact_v1> = natMap.empty<T.Contact_v1>();
    
    // iterate over the old map and add the values to the new map
    for ((key, value) in natMap.entries(old.contactMap)) {
      newcontactMap := natMap.put(newcontactMap, key, { 
        id = key; 
        firstName = value.firstName; 
        lastName = "" 
        });
    };
    // return the new map
    { var contactMap = newcontactMap }
  }
}