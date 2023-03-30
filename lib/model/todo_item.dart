class TodoItem {
  TodoItem({
    required this.name,
    this.isClear = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        name: json['name'] as String,
        isClear: json['isClear'] as bool,
      );

  final String name;
  final bool isClear;

  TodoItem copyWith({
    String? name,
    bool? isClear,
  }) =>
      TodoItem(
        name: name ?? this.name,
        isClear: isClear ?? this.isClear,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'isClear': isClear,
      };
}
