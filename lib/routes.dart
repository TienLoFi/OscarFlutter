export 'package:fluro/fluro.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:oscar_ballot/route_handlers.dart';

final RouteObserver<MaterialPageRoute> routeObserver =
    RouteObserver<MaterialPageRoute>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String siteMain = '/site';
  static const String siteBallotIndex = '/site/ballot/index';
  static const String siteBallotStore = '/site/ballot/store';

  static const String siteGroupList = '/site/group/index';
  static const String siteGroupAdd = '/site/group/add';
  static const String siteGroupJoin = '/site/group/join';
  static const String siteGroupEdit = '/site/group/edit/:id';
  static const String siteGroupDetail = '/site/group/detail/:id';
  static const String siteGroupInviteMember = '/site/group/invite_member/:group_id';
  static const String siteGroupInviteList = '/site/group/invite_list';

  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authVerifyOTP = '/auth/verify_otp/:email/:action';
  static const String authPasswordRemind = '/auth/password_remind';
  static const String authPasswordReset = '/auth/password_reset/:email';

  static const String profileChangeProfile = '/profile/change_profile';

  //movie sidebar
  static const String moviesSideBar = '/functions/moviesidebar';
 //movie sidebar

  static const String profileChangePassword = '/profile/change_password';

  static const String adminUserAdd = '/admin/user/add';
  static const String adminUserEdit = '/admin/user/edit/:id';
  static const String adminUserList = '/admin/user/list';
  static const String adminUserDetail = '/admin/user/detail/:id';

  static const String adminAwardResultAdd = '/admin/awardresult/add';
  static const String adminAwardResultEdit = '/admin/awardresult/edit';
  static const String adminAwardResultList = '/admin/awardresult/list';
  static const String adminAwardResultDetail = '/admin/awardresult/detail/:id';

  static const String adminGroupAdd = '/admin/group/add';
  static const String adminGroupEdit = '/admin/group/edit/:id';
  static const String adminGroupList = '/admin/group/list';
  static const String adminGroupDetail = '/admin/group/detail/:id';

  static const String adminCategoryAdd = '/admin/category/add';
  static const String adminCategoryEdit = '/admin/category/edit/:id';
  static const String adminCategoryList = '/admin/category/list';
  static const String adminCategoryDetail = '/admin/category/detail/:id';

  static const String adminMovieAdd = '/admin/movie/add';
  static const String adminMovieEdit = '/admin/movie/edit/:id';
  static const String adminMovieList = '/admin/movie/list';
  static const String adminMovieDetail = '/admin/movie/detail/:id';

  static const String adminNominationAdd = '/admin/nomination/add';
  static const String adminNominationEdit = '/admin/nomination/edit/:id';
  static const String adminNominationList = '/admin/nomination/list';
  static const String adminNominationDetail = '/admin/nomination/detail/:id';

  static const String adminSetting = '/admin/setting';

  static final fluro = FluroRouter();

  /// Create all routes. Should call before MaterialApp
  static void createRoutes() {

     fluro.define(authLogin, handler: authLoginHandler);
     fluro.define(authRegister, handler: authRegisterHandler);
     fluro.define(authVerifyOTP, handler: authVerifyOTPHandler);
     fluro.define(authPasswordRemind, handler: authPasswordRemindHandler);
     fluro.define(authPasswordReset, handler: authPasswordResethandler);

     fluro.define(profileChangePassword, handler: profileChangePasswordHandler);
     fluro.define(profileChangeProfile, handler: profileChangeProfileHandler);
    fluro.define(moviesSideBar, handler: moviesSideBarHandler);
     fluro.define(siteMain, handler: siteMainHandler);
     fluro.define(siteBallotIndex, handler: siteBallotHandler);

     fluro.define(siteGroupList, handler: siteMyGroupsHandler);
     fluro.define(siteGroupDetail, handler: siteGroupDetailHandler);
     fluro.define(siteGroupAdd, handler: siteGroupAddHandler);
     fluro.define(siteGroupEdit, handler: siteGroupEditHandler);
     fluro.define(siteGroupJoin, handler: siteGroupJoinHandler);
     fluro.define(siteGroupInviteMember, handler: siteGroupInviteMemberHandler);
     fluro.define(siteGroupInviteList, handler: siteGroupInviteListHandler);

     fluro.define(adminUserAdd, handler: adminUserAddHandler);
     fluro.define(adminUserEdit, handler: adminUserEditHandler);
     fluro.define(adminUserList, handler: adminUserListHandler);
     fluro.define(adminUserDetail, handler: adminUserDetailHandler);

     fluro.define(adminAwardResultAdd, handler: adminAwardResultAddHandler);
     fluro.define(adminAwardResultEdit, handler: adminAwardResultEditHandler);
     fluro.define(adminAwardResultList, handler: adminListAwardResultListHandler);
     fluro.define(adminAwardResultDetail, handler: adminAwardResultDetailHandler);

     fluro.define(adminGroupAdd, handler: adminGroupAddHandler);
     fluro.define(adminGroupEdit, handler: adminGroupEditHandler);
     fluro.define(adminGroupList, handler: adminGroupListHandler);
     fluro.define(adminGroupDetail, handler: adminGroupDetailHandler);

     fluro.define(adminCategoryAdd, handler: adminCategoryAddHandler);
     fluro.define(adminCategoryEdit, handler: adminCategoryEditHandler);
     fluro.define(adminCategoryList, handler: adminCategoryListHandler);
     fluro.define(adminCategoryDetail, handler: adminCategoryDetailHandler);

     fluro.define(adminMovieAdd, handler: adminMovieAddHandler);
     fluro.define(adminMovieEdit, handler: adminMovieEditHandler);
     fluro.define(adminMovieList, handler: adminMovieListHandler);
     fluro.define(adminMovieDetail, handler: adminMovieDetailHandler);

     fluro.define(adminNominationAdd, handler: adminNominationAddHandler);
     fluro.define(adminNominationEdit, handler: adminNominationEditHandler);
     fluro.define(adminNominationList, handler: adminNominationListHandler);
     fluro.define(adminNominationDetail, handler: adminNominationDetailHandler);

     fluro.define(adminSetting, handler: adminSettingHandler);

  }


  /// Alias for sailor navigate
  static Future<dynamic> navigate(BuildContext context, String routeName, Set<Object> set, {Map<String, dynamic>? parameters, TransitionType transition = TransitionType.fadeIn}) {
    return Routes.fluro.navigateTo(
      context,
      routeName,
      transition: transition,
      routeSettings: RouteSettings(arguments: parameters)
    );
  }

}
