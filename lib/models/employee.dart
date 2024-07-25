class Employee {
  final int? id;
  final String name;
  final DateTime expiryDate;
  final double salary;

  Employee({
    this.id,
    required this.name,
    required this.expiryDate,
    required this.salary,
  });

  Employee copyWith({
    int? id,
    String? name,
    DateTime? expiryDate,
    double? salary,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      expiryDate: expiryDate ?? this.expiryDate,
      salary: salary ?? this.salary,
    );
  }
}
