
class ServiceModel {
  String title;
  double value;

  ServiceModel({
    required this.title,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      title: map['title'],
      value: map['value'] ?? -1,
    );
  }

}
