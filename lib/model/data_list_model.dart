class DataListModel {
  final int? id;
  final String? title;
  final String? textDetails;

  DataListModel({
    this.id,
    this.title,
    this.textDetails,
  });

  factory DataListModel.fromJson(Map<String, dynamic> json) {
    return DataListModel(
      id: json['id'],
      title: json['title'],
      textDetails: json['textDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['textDetails'] = textDetails;

    return data;
  }
}
