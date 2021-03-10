class Division {
  int id;
  String name;
  String nameBn;
  List<Districts> districts;

  Division({this.id, this.name, this.nameBn, this.districts});

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameBn = json['name_bn'];
    if (json['districts'] != null) {
      districts = new List<Districts>();
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_bn'] = this.nameBn;
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    return data;
  }
  static List<Division> listFromJson(List<dynamic> json){
    List<Division> _list =[];

    if(json != null && json.length>0){
      json.forEach((element) {
        _list.add(Division.fromJson(element));
      });
    }
    return _list;
  }
}

class Districts {
  int id;
  int divisionId;
  String name;
  String nameBn;
  String createdAt;
  String updatedAt;
  List<Thanas> thanas;

  Districts(
      {this.id,
        this.divisionId,
        this.name,
        this.nameBn,
        this.createdAt,
        this.updatedAt,
        this.thanas});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['division_id'];
    name = json['name'];
    nameBn = json['name_bn'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['thanas'] != null) {
      thanas = new List<Thanas>();
      json['thanas'].forEach((v) {
        thanas.add(new Thanas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['division_id'] = this.divisionId;
    data['name'] = this.name;
    data['name_bn'] = this.nameBn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.thanas != null) {
      data['thanas'] = this.thanas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Thanas {
  int id;
  int districtId;
  String name;
  String description;
  String createdAt;
  String updatedAt;

  Thanas(
      {this.id,
        this.districtId,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt});

  Thanas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_id'] = this.districtId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
