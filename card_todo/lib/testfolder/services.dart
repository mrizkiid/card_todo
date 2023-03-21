import 'package:hive/hive.dart';
import './hive/model/user.dart';

class RepoData {
  late Box<User> box;

  Future<void> init() async {
    var box = await Hive.openBox('testBox');
  }

  List<
}
