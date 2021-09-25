class HistoryModel {
  // underscore '_' in front of variable and mthods means that particular element of the class is private.
  String time;
  String email;
  String date;
  String name;
  String id;
  String mobile;
  String yogas;
  String problems;

  // When we pass a parameter in a constructor with this keyword in flutter, the value you pass will  automatically linked to their respective properties
  // An optional parameter is passed in square brackets. (e.g. -> [this._description])

  // Constructor 1 -> when we create a new Todo and the database hasn't assigned an id yet.
  HistoryModel();

  // There can be only one un-named constructor in a class, sohere we have to use a named constructor.

  // Constructor 2 -> when we have an id for e.g. when we are editing the todo.
  HistoryModel.withId(this.id, this.time, this.email, this.date, this.name,
      this.mobile, this.problems, this.yogas);

  // method to transform out Todo into a map, this will come handy when we will use some helper methods in squlite
  Map<String, dynamic> toMap() {
    // To know about 'dynamic' keyword: https://stackoverflow.com/a/59107168/10204932
    var map = Map<String, dynamic>();
    map["time"] = time;
    map["email"] = email;
    map["date"] = date;
    map["name"] = name;
    map["mobile"] = mobile;
    map["yogas"] = yogas;
    map["problems"] = problems;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

// Constructor 3 -> This will do just opposite of toMap(); It will take a dynamic object and covert it into a Todo
  HistoryModel.toObject(dynamic o) {
    this.id = o["id"];
    this.time = o["time"];
    this.email = o["email"];
    this.date = o["date"];
    this.name = o["name"];
    this.mobile = o["mobile"];
    this.problems = o["problems"];
    this.yogas = o["yogas"];
  }
}
