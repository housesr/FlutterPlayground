import 'package:app/shared/data/user/entities/user_response.dart';

class SearchUsersResponse {
  int? totalCount;
  bool? incompleteResults;
  List<UserResponse>? items;

  SearchUsersResponse({this.totalCount, this.incompleteResults, this.items});

  SearchUsersResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <UserResponse>[];
      json['items'].forEach((e) {
        items!.add(UserResponse.fromJson(e));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
