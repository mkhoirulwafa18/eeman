import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 1)
class Alarm extends HiveObject {
  @HiveField(0, defaultValue: <DateTime>[])
  List<DateTime>? alarmList;
}
