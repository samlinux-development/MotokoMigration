import Nat "mo:base/Nat";
import OrderedMap "mo:base/OrderedMap";
import Iter "mo:base/Iter";

import T "./types/types";

//import ContactMigration "./migration/ContactMigration_1";
//(with migration = ContactMigration.migration)

persistent actor {
  
  private var nextId : Nat = 1;
  private var contactMap : OrderedMap.Map<Nat, T.Contact> = OrderedMap.Make<Nat>(Nat.compare).empty<T.Contact>();

  public func addContact(contact : T.ContactAdd) : async Nat {
    let id = nextId;
    nextId += 1;
    let newContact = { id = id; firstName = contact.firstName; };
    contactMap := OrderedMap.Make<Nat>(Nat.compare).put(contactMap, id, newContact);
    id
  };

  public func updateContact(contact : T.Contact) : async Bool {
    let natMap = OrderedMap.Make<Nat>(Nat.compare);
    switch (natMap.get(contactMap, contact.id)) {
      case null { false };
      case (?existingRecord) {
        let updatedContact = { id = existingRecord.id; firstName = contact.firstName; };
         contactMap := natMap.put(contactMap, existingRecord.id, updatedContact);
         true
      };
    };
  };

  public query func getContact(id : Nat) : async ?T.Contact {
    OrderedMap.Make<Nat>(Nat.compare).get(contactMap, id)
  };

  public query func getContacts() : async [(Nat, T.Contact)] {
    Iter.toArray(OrderedMap.Make<Nat>(Nat.compare).entries(contactMap))
  };
}