class Pray {
  const Pray({required this.name, required this.time});
  final String name;
  final String time;

  @override
  String toString() {
    return 'Pray(name: $name, time: $time)';
  }
}
