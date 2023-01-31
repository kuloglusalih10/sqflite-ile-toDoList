class task {
  int? id;
  late String name;
  late String description;

  task.idn({required this.name,required this.description});
  task(this.id, this.name, this.description);


  task.fromJson(dynamic json) {
    this.id = json["id"];
    this.name = json["name"];
    this.description = json["description"];
  }

  Map<String,dynamic> toJson() {
    var data = Map<String, dynamic>();
    if(id != null)
    {
      data["id"] = id;
    }
    data["name"] = name;
    data["description"] = description;
    return data;
  }
}