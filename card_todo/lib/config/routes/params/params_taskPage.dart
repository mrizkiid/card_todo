import 'package:card_todo/config/routes/params/params.dart';

class TaskPageParams extends RouteParams {
  final String title;
  final String keyValue;
  final int index;

  const TaskPageParams({
    required this.title,
    required this.keyValue,
    required this.index,
  });
}
