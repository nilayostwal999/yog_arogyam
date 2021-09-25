class RequestModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String id;
  String email;
  String firstName;
  String lastName;
  String mobile;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  // UserModel(this._email, this._username, this._firstName, this._lastName,
  //     this._country, this._state, this._city, this._mobile, this._password,
  //     [this._imagePath]);

  RequestModel();
  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  RequestModel.withId(
      this.id, this.email, this.firstName, this.lastName, this.mobile);

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["email"] = email;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["mobile"] = mobile;

    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  RequestModel.toObject(dynamic o) {
    this.id = o["id"];
    this.email = o["email"];
    this.firstName = o["firstName"];
    this.lastName = o["lastName"];
    this.mobile = o["mobile"];
  }
}
