import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:leasing_company/api/api.dart';
import 'package:leasing_company/api/remote_data_source.dart';
import 'package:leasing_company/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_accessed_by.dart';
import 'package:leasing_company/features/tasks/domain/enums/task_status.dart';
import 'package:leasing_company/features/tasks/domain/help_models/create_task_model.dart';
import 'package:leasing_company/features/tasks/domain/help_models/update_task_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_cursor_pagination_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_mini_model.dart';
import 'package:leasing_company/features/tasks/domain/models/task_model.dart';
import 'package:leasing_company/main.dart';

class TaskRemoteDatasourceImpl extends RemoteDataSource
    implements TaskRemoteDatasource {
  @override
  Future<TaskModel> getById(
      {required String companyUuid, required int id}) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    String url = apiUrl + '/v2/tasks/$id';

    var response = await Api.client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Tenant-Id': companyUuid,
      },
    ).timeout(Duration(seconds: 15));

    var data = jsonDecode(response.body);

    return TaskModel.fromJson(data['data']);
  }

  @override
  Future<List<TaskMiniModel>> getList({
    required String companyUuid,
    required TaskAccessedBy accessedBy,
    required TaskStatus? status,
    required String? cursor,
    required int limit,
    String? search,
  }) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    String url = apiUrl + '/v2/tasks?accessed_by=${accessedBy.value}';

    if (status != null) {
      url += '&status=${status.value}';
    }

    if (cursor != null) {
      url += '&cursor=$cursor';
    }

    url += '&per_page=$limit';

    var response = await Api.client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Tenant-Id': companyUuid,
      },
    ).timeout(Duration(seconds: 15));

    var data = jsonDecode(response.body);

    List<TaskMiniModel> tasks = List<TaskMiniModel>.from(
        data['data'].map((taskJson) => TaskMiniModel.fromJson(taskJson)));

    return tasks;
  }

  @override
  Future<bool> changeStatus({
    required String companyUuid,
    required int id,
    required TaskStatus status,
  }) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    String url = apiUrl + '/v1/tasks/$id/change-status';

    var response = await Api.client.post(
      Uri.parse(url),
      body: {'status': status.value},
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Tenant-Id': companyUuid,
      },
    ).timeout(Duration(seconds: 15));

    return response.statusCode == 202;
  }

  Future<bool> store(TaskModel task, {required String companyUuid}) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    var response = await Api.client
        .post(Uri.parse(apiUrl + "/v1/tasks"), body: jsonEncode({}), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + accessToken,
      'Tenant-Id': companyUuid,
    }).timeout(Duration(seconds: 15));

    return response.statusCode == 201;
  }

  Future<bool> update(TaskModel task, {required String companyUuid}) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    var response = await Api.client.post(
        Uri.parse(apiUrl + "/v1/tasks/${task.remoteId}"),
        body: jsonEncode({}),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));

    return response.statusCode == 200;
  }

  @override
  Future<TaskCursorPaginationModel> getPaginationList(
      {required String companyUuid,
      required TaskAccessedBy accessedBy,
      required TaskStatus? status,
      required String? cursor,
      required int limit}) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    String url = apiUrl + '/v1/tasks?accessed_by=${accessedBy.value}';

    if (status != null) {
      url += '&status=${status.value}';
    }

    if (cursor != null) {
      url += '&cursor=$cursor';
    }

    url += '&per_page=$limit';

    var response = await Api.client.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + accessToken,
        'Tenant-Id': companyUuid,
      },
    ).timeout(Duration(seconds: 15));

    var data = jsonDecode(response.body);

    return TaskCursorPaginationModel.fromJson(data);
  }

  @override
  Future<bool> createTask(CreateTaskModel newTask, String companyUuid) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    var response = await Api.client.post(Uri.parse(apiUrl + "/v1/tasks"),
        body: jsonEncode(newTask.toJson()),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));

    return response.statusCode == 201;
  }

  @override
  Future<bool> updateTask(
      UpdateTaskModel updateTaskModel, String companyUuid) async {
    Box appBox = getIt.get(instanceName: 'AppBox');
    String accessToken = appBox.get('accessToken');

    var response = await Api.client.put(
        Uri.parse(apiUrl + "/v1/tasks/${updateTaskModel.taskId}"),
        body: jsonEncode(updateTaskModel.toJson()),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));

    return response.statusCode == 201;
  }
}
