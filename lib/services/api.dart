import 'dart:async';
import 'dart:convert';
import 'package:oscar_ballot/blocs/blocs.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:http/http.dart' as http;
import 'package:oscar_ballot/models/award_result.dart';
import 'package:oscar_ballot/models/movie.dart';

class Api {
  static Api _instance = Api._internal();
  final _client = http.Client();
  UserBloc _userBloc = BlocProvider.getBloc<UserBloc>();
  Api._internal();

  factory Api() => _instance;

  Future<Map<String, dynamic>> request(String method, String url,
      [Map<String, dynamic>? params, Map<String, String>? headers]) async {
    Map<String, String> reqHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    if (headers != null) {
      reqHeaders.addAll(headers);
    }

    Uri parsedUrl = Uri.parse(url);

    final body = params ?? <String, dynamic>{};
    http.Response res;
    const timeout = Duration(seconds: 30);
    switch (method.toLowerCase()) {
      case "post":
        res = await _client
            .post(parsedUrl, headers: reqHeaders, body: json.encode(body))
            .timeout(timeout);
      case "patch":
        res = await _client
            .patch(parsedUrl, headers: reqHeaders, body: json.encode(body))
            .timeout(timeout);
      case "get":
      default:
        if (body.isNotEmpty) {
          url = buildQueryString(url, body);
          Uri uri = Uri.parse(url);
          res = await _client.get(uri, headers: reqHeaders).timeout(timeout);
        } else {
          res = await _client.get(parsedUrl, headers: reqHeaders).timeout(timeout);
        }

    }
    final result = json.decode(utf8.decode(res.bodyBytes));
    return result;
  }

  String buildQueryString(String baseUrl, Map<String, dynamic> queryParams) {
    Map<String, String> stringParams = queryParams.map((key, value) => MapEntry(key, value.toString()));
    Uri uri = Uri.parse(baseUrl).replace(queryParameters: stringParams);
    return uri.toString();
  }

  Future<Map<String, dynamic>> updateInfo({
    String firstName = '',
    String lastName = '',
    String phone = '',
  }) async {
    final res = await Api().request(
      'patch',
      '${Consts.apiUrl}/api/me/update',
      {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> loginSocial(String network, String token) async {
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/login/social',
      {
        "network": network,
        "social_token": token,
      },
    );

    return res;
  }

  Future<Map<String, dynamic>> loginFacebook(String token) =>
      Api().loginSocial('facebook', token);

  Future<Map<String, dynamic>> loginTwitter(String token) =>
      Api().loginSocial('twitter', token);


  Future<Map<String, dynamic>> loginEmailPassword(
      String email, String password) async {
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/auth/login',
      {
        "email": email,
        "password": password,
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/auth/register',
      {
        "email": email,
        "name": name,
        "password": password,
        "password_confirmation": confirmPassword
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> resetPassword(
    String email,
    String password,
    String confirmPassword,
    String verifyCode
  ) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/auth/password_reset',
      {
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "verify_code": verifyCode
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> passwordRemind(String email) async {
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/auth/password_remind',
      {
        "email": email,
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> changePassword({
    String passwordOld = '',
    String password = '',
    String confirmPassword = '',
  }) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/profile/password_change',
      {
        "password_old": passwordOld,
        "password": password,
        "password_confirmation": confirmPassword,
      },
      headers
    );
    return res;
  }

    Future<Map<String, dynamic>> changProfile({
    String name = '',
    String email = '',
  }) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/profile/change_profile',
      {
        "name": name,
        "email": email,
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> getMyProfile() async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = await Api().request(
      'get',
      '${Consts.apiUrl}/api/profile/my_profile',
      null,
      headers
    );
    return res;
  }

  Future<AwardResultList> getAwardResultList([
    int limit = 10,
    String keyword = '',
    int categoryId = -1,
  ]) async {
    Map<String, String> params = {
      'limit': limit.toString(),
    };

    if (keyword.isNotEmpty) {
      params['keyword'] = keyword;
    }

    if (categoryId > 0) {
      params['category_id'] = categoryId.toString();
    }

    final res = await Api().request(
      'get',
      '${Consts.apiUrl}/api/admin/awardresult/list',
      params,
    );


    return AwardResultList.fromJson(res);
  }
//movies
// Function to fetch movies from API
Future<MovieList> getMovieList({
  int limit = 10,
  String keyword = '',
  int categoryId = -1,
}) async {
  Map<String, String> params = {
    'limit': limit.toString(),
  };

  if (keyword.isNotEmpty) {
    params['keyword'] = keyword;
  }

  if (categoryId > 0) {
    params['category_id'] = categoryId.toString();
  }

  try {
    final res = await Api().request(
      'get',
      '${Consts.apiUrl}/api/admin/movie/list',
      params,
    );

    return MovieList.fromJson(res); // Return the parsed MovieList object
  } catch (e) {
    print('Error fetching movie list: $e');
    throw e; // Rethrow the error to propagate it further if needed
  }
}
//
  Future<Map<String, dynamic>> verifyOTP(
      String email,
      String action,
      String otp
  ) async {
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/auth/verify_otp',
      {
        "email": email,
        "action": action,
        "otp": otp
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> resendOTP(
      String email,
      String action
  ) async {
    final res = await Api().request(
      'post',
      '${Consts.apiUrl}/api/auth/resend_otp',
      {
        "email": email,
        "action": action,
      },
    );
    return res;
  }

  Future<Map<String, dynamic>> siteBallotIndex() async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res =  Api().request(
      'get',
      '${Consts.apiUrl}/api/site/ballot/index',
      null,
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteBallotStore (
    int mostOscar,
    int howMany,
    List<Map<String, dynamic>> answers
  ) {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/ballot/store',
      {
        "most_oscar_movie_id": mostOscar,
        "how_many": howMany,
        "answers": answers
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupIndex(int page, int limit, int status, String search) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res =  Api().request(
      'get',
      '${Consts.apiUrl}/api/site/group/index',
      {
        "page": "$page",
        "limit": "$limit",
        "status": "$status",
        "search": search
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupAdd (
    String name,
    String desc,
    int status,
    String groupNumber,
    String groupPassword
  ) {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/add',
      {
        "name": name,
        "desc": desc,
        "status": status,
        "group_number": groupNumber,
        "group_password": groupPassword
      },
      headers
    );
    return res;
  }

    Future<Map<String, dynamic>> siteGroupUpdate (
    int groupId,
    String name,
    String desc,
    String groupNumber,
    String groupPassword
  ) {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/update/$groupId',
      {
        "name": name,
        "desc": desc,
        "group_number": groupNumber,
        "group_password": groupPassword
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupJoin (
    String groupNumber,
    String groupPassword
  ) {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/join_group',
      {
        "group_number": groupNumber,
        "group_password": groupPassword
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupDetail(int groupId) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res =  Api().request(
      'get',
      '${Consts.apiUrl}/api/site/group/detail/$groupId',
      null,
      headers
    );
    return res;
  }


  Future<Map<String, dynamic>> siteGroupSendInvite (
    List<int> memberIds,
    int groupId
  ) {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/send_invite',
      {
        "member_ids": memberIds,
        "group_id": groupId
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupSearchMember(String search) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res =  Api().request(
      'get',
      '${Consts.apiUrl}/api/site/group/search_members',
      {
        "search": search
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupDelete(int groupId) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/delete/$groupId',
      null,
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupLeave(int groupId) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/leave/$groupId',
      null,
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupRemoveMember(int groupId, int userId) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/delete_member',
      {
        'member_id': userId,
        'group_id': groupId
      },
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupAcceptInvite(int inviteId) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/accept_invite/$inviteId',
      null,
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupRejectInvite(int inviteId) async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res = Api().request(
      'post',
      '${Consts.apiUrl}/api/site/group/reject_invite/$inviteId',
      null,
      headers
    );
    return res;
  }

  Future<Map<String, dynamic>> siteGroupInvitationList() async {
    String accessToken = _userBloc.accessToken;
    Map<String, String> headers = {
      'Authorization': "Bearer $accessToken"
    };
    final res =  Api().request(
      'get',
      '${Consts.apiUrl}/api/site/group/invitation_list',
      null,
      headers
    );
    return res;
  }

  setState(Null Function() param0) {}

}
