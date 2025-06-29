# MotokoMigration

A Motoko-based contact management system with persistent storage capabilities.

## Overview

This project provides a simple contact management system built with Motoko on the Internet Computer. It allows you to add, update, retrieve, and list contact records with persistent storage.

## Public Methods

### 1. `addContact(contact: ContactAdd) -> async Nat`

Adds a new contact record to the system.

**Parameters:**
- `contact`: A ContactAdd object with `firstName` (Text)

**Returns:**
- `Nat`: The unique ID assigned to the new contact

**CLI Usage:**
```bash
# Add a new contact
dfx canister call backend addContact '(record { firstName = "John" })'

# Add another contact
dfx canister call backend addContact '(record { firstName = "Jane" })'
```

### 2. `updateContact(contact: Contact) -> async Bool`

Updates an existing contact record by ID.

**Parameters:**
- `contact`: A Contact object with `id` (Nat) and `firstName` (Text)

**Returns:**
- `Bool`: `true` if the contact was successfully updated, `false` if the contact ID doesn't exist

**CLI Usage:**
```bash
# Update contact with ID 0
dfx canister call backend updateContact '(record { id = 0; firstName = "John Updated" })'

# Update contact with ID 1
dfx canister call backend updateContact '(record { id = 1; firstName = "Jane Updated" })'
```

### 3. `getContact(id: Nat) -> async ?Contact`

Retrieves a specific contact record by ID.

**Parameters:**
- `id`: The unique identifier of the contact (Nat)

**Returns:**
- `?Contact`: The contact record if found, or `null` if not found

**CLI Usage:**
```bash
# Get contact with ID 0
dfx canister call backend getContact '(0)'

# Get contact with ID 1
dfx canister call backend getContact '(1)'
```

### 4. `getAllContacts() -> async [(Nat, Contact)]`

Retrieves all contact records in the system.

**Parameters:**
- None

**Returns:**
- `[(Nat, Contact)]`: Array of tuples containing (ID, Contact) pairs

**CLI Usage:**
```bash
# Get all contacts
dfx canister call backend getAllContacts '()'
```

## Data Types

### Contact
```motoko
type Contact = {
  id : Nat;
  firstName : Text;
};
```

### ContactAdd
```motoko
type ContactAdd = {
  firstName : Text;
};
```

## Getting Started

### Prerequisites
- DFX (Internet Computer SDK)
- A local Internet Computer replica or connection to mainnet

### Setup and Deployment

1. **Start the local replica:**
```bash
dfx start --background
```

2. **Deploy the canister:**
```bash
dfx deploy
```

3. **Test the methods:**
```bash
# Add some contacts
dfx canister call backend addContact '(record { firstName = "Alice" })'
dfx canister call backend addContact '(record { firstName = "Bob" })'

# List all contacts
dfx canister call backend getAllContacts '()'

# Get a specific contact
dfx canister call backend getContact '(0)'

# Update a contact
dfx canister call backend updateContact '(record { id = 0; firstName = "Alice Updated" })'
```

## Example Workflow

Here's a complete example of using the contact management system:

```bash
# 1. Deploy the canister
dfx deploy

# 2. Add contacts
dfx canister call backend addContact '(record { firstName = "John Doe" })'
# Returns: (0)

dfx canister call backend addContact '(record { firstName = "Jane Smith" })'
# Returns: (1)

# 3. List all contacts
dfx canister call backend getAllContacts '()'
# Returns: vec { (0 : nat, record { id = 0; firstName = "John Doe" }); (1 : nat, record { id = 1; firstName = "Jane Smith" }) }

# 4. Get a specific contact
dfx canister call backend getContact '(0)'
# Returns: (opt record { id = 0; firstName = "John Doe" })

# 5. Update a contact
dfx canister call backend updateContact '(record { id = 0; firstName = "John Updated" })'
# Returns: (true)

# 6. Verify the update
dfx canister call backend getContact '(0)'
# Returns: (opt record { id = 0; firstName = "John Updated" })
```

## Notes

- The system automatically assigns unique IDs to new contacts
- When adding contacts, only provide the `firstName` - the ID will be auto-generated
- Contact updates require the exact ID of the existing contact
- All data is persisted using Motoko's orthogonal persistence
- The `getAllContacts()` method returns contacts in the order they were added


### Example Migration Scenario

Adding a `lastName` field to contacts:
- Old type: `{ id: Nat, firstName: Text }`
- New type: `{ id: Nat, firstName: Text, lastName: Text }`
- Migration: Set `lastName = ""` for all existing contacts

