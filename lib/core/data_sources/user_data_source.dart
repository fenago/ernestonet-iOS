// import 'package:hive/hive.dart';

// import '../../locator.dart';
// import '../constants/local_storage_keys.dart';
// import '../models/user.dart';

// abstract class UserDataSourceBase {
//   Future<void> init();
//   Future<void> cacheUser(User user);
//   User getUser();
// }

// class UserDataSource implements UserDataSourceBase {
//   final _hiveService = locator<HiveInterface>();
//   bool initialized = false;

//   Box<User> _userBox;
//   bool _isUserBoxOpen;

//   @override
//   Future<void> init() async {
//     if (!initialized) {
//       initialized = true;
//       _hiveService.registerAdapter<User>(UserAdapter());
//     }
//     _userBox = await _hiveService.openBox(HiveDatabaseKeys.user);
//     _isUserBoxOpen = _hiveService.isBoxOpen(HiveDatabaseKeys.user);
//     print('Box status : $_isUserBoxOpen');
//     if (!_isUserBoxOpen) {
//       _userBox = await _hiveService.openBox(HiveDatabaseKeys.user);
//     }
//   }

//   @override
//   Future<void> cacheUser(User user) async {
//     if (_isUserBoxOpen) {
//       await _userBox.add(user);
//     }
//   }

//   @override
//   User getUser() {
//     if (_userBox.isEmpty) {
//       // throw CacheException('No course found in cache');
//       return null;
//     }
//     return _userBox.values.first;
//   }

// }