// import 'package:supabase/supabase.dart';
import 'package:kotgltd/data/enviroment_creds.dart';
import 'package:kotgltd/packages/core.dart';
import 'package:http/http.dart' as http;

class StoriesRepository {
  Future<List> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('${Env.domainUrl}/wp-json/wp/v2/posts'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        },
      );
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 403) {
        throw Exception('Forbidden');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode == 400) {
        throw Exception("Bad Request");
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      // Decode the json response
      final jsonResponse = json.decode(response.body);

      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future fetchPost({required String id}) async {
    try {
      final response = await http.get(
        Uri.parse('${Env.domainUrl}/wp-json/wp/v2/posts/${id}'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        },
      );

      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 403) {
        throw Exception('Forbidden');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode == 400) {
        throw Exception("Bad Request");
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception(response.body);
      }

      // Decode the json response
      final jsonResponse = json.decode(response.body);

      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }
}
