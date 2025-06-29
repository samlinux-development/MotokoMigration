module {
  
  public type Contact = {
    id : Nat;
    firstName : Text;
  };
  
  public type ContactAdd = {
    firstName : Text;
  };

  // migration types
  public type Contact_v1 = {
    id : Nat;
    firstName : Text;
    lastName : Text;
  };

   public type ContactAdd_v1 = {
    firstName : Text;
    lastName : Text;
  };
}
