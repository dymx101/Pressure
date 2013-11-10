//
//  LVXmppManager.h
//  Unity-iPhone
//
//  Created by 郑 eason on 13-9-8.
//
//

#import <Foundation/Foundation.h>
#import "RPAuthModel.h"
#import "RPXmppProfile.h"
@interface RPXmppManager : NSObject

+ (RPXmppManager *)sharedInstance ;


- (void)doConnect:(NSString *)xmppUserName xmppPassWord:(NSString *)xmppPassword;
- (void)sendOnlineStatus:(User_Xmpp_OnlineStatus)status;
- (void)sendMessage:(NSString *)message toUser:(RPXmppProfile *)toUser;


@end
