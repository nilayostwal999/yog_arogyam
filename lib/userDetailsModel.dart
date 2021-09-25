class UserDetailsModel {
  String problems;
  String age;
  String weight;
  String id;
  String height;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  UserDetailsModel();

  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  UserDetailsModel.withId(
    this.id,
    this.problems,
    this.age,
    this.height,
    this.weight,
  );

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["problems"] = problems;
    map["age"] = age;
    map["weight"] = weight;
    map["height"] = height;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  UserDetailsModel.toObject(dynamic o) {
    this.id = o["id"];
    this.height = o["height"];
    this.weight = o["weight"];
    this.age = o["age"];
    this.problems = o["problems"];
  }
}
