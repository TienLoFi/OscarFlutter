import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:oscar_ballot/pages/admin/awardresult/add.dart';
import 'package:oscar_ballot/pages/admin/awardresult/detail.dart';
import 'package:oscar_ballot/pages/admin/awardresult/list.dart';
import 'package:oscar_ballot/pages/admin/category/add.dart';
import 'package:oscar_ballot/pages/admin/category/detail.dart';
import 'package:oscar_ballot/pages/admin/category/edit.dart';
import 'package:oscar_ballot/pages/admin/category/list.dart';
import 'package:oscar_ballot/pages/admin/group/add.dart';
import 'package:oscar_ballot/pages/admin/group/detail.dart';
import 'package:oscar_ballot/pages/admin/group/edit.dart';
import 'package:oscar_ballot/pages/admin/group/list.dart';
import 'package:oscar_ballot/pages/admin/movie/add.dart';
import 'package:oscar_ballot/pages/admin/movie/detail.dart';
import 'package:oscar_ballot/pages/admin/movie/edit.dart';
import 'package:oscar_ballot/pages/admin/movie/list.dart';
import 'package:oscar_ballot/pages/admin/nomination/add.dart';
import 'package:oscar_ballot/pages/admin/nomination/detail.dart';
import 'package:oscar_ballot/pages/admin/nomination/edit.dart';
import 'package:oscar_ballot/pages/admin/nomination/list.dart';
import 'package:oscar_ballot/pages/admin/setting/admin_setting.dart';
import 'package:oscar_ballot/pages/admin/user/add.dart';
import 'package:oscar_ballot/pages/admin/user/detail.dart';
import 'package:oscar_ballot/pages/admin/user/edit.dart';
import 'package:oscar_ballot/pages/admin/user/list.dart';
import 'package:oscar_ballot/pages/auth/password_remind.dart';
import 'package:oscar_ballot/pages/auth/password_reset.dart';
import 'package:oscar_ballot/pages/auth/register.dart';
import 'package:oscar_ballot/pages/auth/verify_otp.dart';
import 'package:oscar_ballot/pages/main.dart';
import 'package:oscar_ballot/pages/profile/change_password.dart';
import 'package:oscar_ballot/pages/auth/login.dart';
import 'package:oscar_ballot/pages/profile/change_profile.dart';
import 'package:oscar_ballot/pages/functions/moviesidebar.dart';
//movies
// import 'package:oscar_ballot/pages/functions/moviesidebar.dart';
import 'package:oscar_ballot/pages/site/ballot/ballot.dart';
import 'package:oscar_ballot/pages/site/group/add.dart';
import 'package:oscar_ballot/pages/site/group/detail.dart';
import 'package:oscar_ballot/pages/site/group/edit.dart';
import 'package:oscar_ballot/pages/site/group/invite_list.dart';
import 'package:oscar_ballot/pages/site/group/invite_member.dart';
import 'package:oscar_ballot/pages/site/group/join.dart';
import 'package:oscar_ballot/pages/site/group/my_groups.dart';
import 'package:oscar_ballot/pages/site/main_feature.dart';

var adminAwardResultAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminAwardResultAdd();
});

var adminAwardResultDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminAwardResultDetail();
});


var adminAwardResultEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminAwardResultDetail();
});

var adminListAwardResultListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminAwardResultList();
});

var adminCategoryAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminCategoryAdd();
});

var adminCategoryEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminCategoryEdit();
});

var adminCategoryDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminCategoryDetail();
});

var adminCategoryListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminCategoryList();
});


var adminGroupAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminGroupAdd();
});

var adminGroupDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminGroupDetail();
});

var adminGroupEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminGroupEdit();
});

var adminGroupListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminGroupList();
});

var adminMovieAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminMovieAdd();
});

var adminMovieDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminMovieDetail();
});

var adminMovieEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminMovieEdit();
});

var adminMovieListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminMovieList();
});

var adminNominationAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminNominationAdd();
});

var adminNominationDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminNominationDetail();
});

var adminNominationEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminNominationEdit();
});

var adminNominationListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminNominationList();
});

var adminSettingHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminSetting();
});

var adminUserAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminUserAdd();
});

var adminUserDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminUserDetail();
});

var adminUserEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminUserEdit();
});

var adminUserListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AdminUserList();
});


var authLoginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AuthLoginPage();
});

var authRegisterHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AuthRegisterPage();
});

var authVerifyOTPHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      var email = params['email']?[0];
      var action = params['action']?[0];
      return AuthVerifyOTPPage(email:email!, action: action!);
});

var authPasswordRemindHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AuthPasswordRemindPage();
});

var authPasswordResethandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      var email = params['email']?[0];
  return AuthPasswordResetPage(email:email!);
});

var profileChangePasswordHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ProfileChangePasswordPage();
});

var profileChangeProfileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ProfileChangeProfilePage();
});

//movies
var moviesSideBarHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MovieSideBarPage();
});
//

var siteBallotHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteBallotPage();
});

var siteGroupAddHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteGroupAddPage();
});


var siteGroupDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  var groupId = int.parse(params['id']![0]);
  return SiteGroupDetailPage(groupId: groupId);
});

var siteGroupEditHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  var groupId = int.parse(params['id']![0]);
  return SiteGroupEditPage(groupId: groupId);
});

var siteGroupJoinHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteGroupJoinPage();
});

var siteGroupInviteMemberHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      var groupId = int.parse(params['group_id']![0]);
  return SiteGroupInviteMemberPage(groupId: groupId);
});

var siteGroupInviteListHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteGroupInviteListPage();
});

var siteMyGroupsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteMyGroupsPage();
});


var siteMainFeatureHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteMainFeature();
});


var siteMainHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SiteMainPage();
});
