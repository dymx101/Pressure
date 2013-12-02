//
//  RPServerApiDef.h
//  Pressure
//
//  Created by eason on 3/11/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#ifndef Pressure_RPServerApiDef_h
#define Pressure_RPServerApiDef_h

#import "RPServerRequest.h"
#import "RPServerResponse.h"
#import "RPServerOperation.h"

#define kServerApi_RefreshToken     @"refreshToken"
#define kServerApi_ThirdPartLogin   @"thirdPartLogin"
#define kServerApi_FrMatch          @"frMatch"
#define kServerApi_GetChatTypeList  @"getChatTypeList"
#define kServerApi_UpdateMatchType  @"updateMatchType"
#define kServerApi_GetUserProfileByJid  @"getUserProfileByJid"
#define kServerApi_Login            @"login"
#define kServerApi_RegisterUser     @"registerUser"
#define kServerApi_UpdateUserProfile  @"updateProfile"
#define kServerApi_SyncUserChatingUsers  @"syncUserChatingUsers"

//论坛
#define kServerApi_Add_To_Forum          @"addForum"
#define kServerApi_Get_Forum_List        @"getForumList"

#endif
