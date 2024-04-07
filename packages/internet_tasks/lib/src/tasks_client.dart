// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasks_api/tasks_api.dart';

class TaskClient {
  TaskClient({
    http.Client? httpClient,
    this.baseUrl = 'https://reqres.in/api/tasks',
  }) : httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client httpClient;

  Future<String?> getTasks(String pageNumber, String perPage) async {
    try {
      final queryParameters = 'page=$pageNumber&per_page=$perPage';
      final taskRequest = Uri.parse('$baseUrl?$queryParameters');

      final response = await httpClient.get(taskRequest);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Task?> addTask(Task task) async {
    try {
      final taskRequest = Uri.parse(baseUrl);

      final response =
          await httpClient.post(taskRequest, body: jsonEncode(task));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return task;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Task?> updateTask(Task task) async {
    try {
      final taskRequest = Uri.parse('$baseUrl/${task.id}');

      final response =
          await httpClient.put(taskRequest, body: jsonEncode(task));

      if (response.statusCode == 200) {
        return task;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(int id) async {
    try {
      final taskRequest = Uri.parse('$baseUrl/$id');

      final response = await httpClient.delete(taskRequest);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
