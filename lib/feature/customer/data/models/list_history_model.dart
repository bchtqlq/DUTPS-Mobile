import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dut_packing_system/feature/customer/data/models/history_model.dart';

@jsonSerializable
@Json(caseStyle: CaseStyle.snake, ignoreNullMembers: true)
class ListHistoryModel {
  List<dynamic>? list;

  ListHistoryModel({this.list});

  factory ListHistoryModel.fromJson(Map<String, dynamic> json) {
    return ListHistoryModel(
      list: List<HistoryModel>.from(json["list"].map((x) => HistoryModel.fromJson(x))),
    );
  }

  List<HistoryModel> getListHistory() {
    if (list == null) {
      return <HistoryModel>[];
    }
    List<HistoryModel> result = <HistoryModel>[];
    for (var element in list!) {
      result.add(HistoryModel.fromJson(element));
    }
    return result;
  }
}
