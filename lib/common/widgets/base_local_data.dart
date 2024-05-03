import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/services/local_data_service.dart';

/// [BaseLocalData] is a class that makes us easier
/// to get, set, and remove local storage data.
/// We can use the [getValue], [setValue], and [removeValue]
/// methods when we extend this base class.
///
/// For example, if we want to save token data (string),
/// we can define it like this:
/// ```
/// class TokenLocalData extends BaseLocalData {
///   @override
///   String get key => 'token';
/// }
/// ```
/// and then, we can use it like this:
/// ```
/// await TokenLocalData().setValue('asd123');
/// var value = await TokenLocalData().getValue();
/// print(value); // it will return 'asd123'
///
/// await TokenLocalData().remove();
/// var value = await TokenLocalData().getValue();
/// print(value) // it will return null
/// ```

abstract class BaseLocalData {
  String get key;

  final localData = locator<LocalDataServiceImpl>();

  Future<String?> getValue() async {
    final value = await localData.getString(key);

    return value;
  }

  Future<void> setValue(String value) async {
    await localData.setString(key, value);
  }

  Future<void> setListValue(List<String> value) async {
    await localData.setStringList(key, value);
  }

  Future<List<String>?> getListValue() async {
    final value = await localData.getStringList(key);

    return value;
  }

  Future<void> removeValue() async {
    await localData.remove(key);

    return;
  }
}
