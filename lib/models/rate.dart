class Rate {
  String from;
  String to;
  double multiplier;
  DateTime updatedAt;

  Rate({this.from, this.to, this.multiplier, this.updatedAt});

  factory Rate.fromJson(Map<String, dynamic> data) {
    return Rate(
      from: data['base'],
      to: data['rates'].keys.first,
      multiplier: data['rates'].values.first,
      updatedAt: DateTime.parse(data['date']),
    );
  }
}