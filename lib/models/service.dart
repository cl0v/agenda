import 'dart:convert';

class ServiceModel {
  String title;
  // double value;

  ServiceModel({
    required this.title,
    // required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) => ServiceModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ServiceModel &&
      other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
