//
//#import "EHSysScreen.h"

#import <Foundation/Foundation.h>
#import "EHSysProperty.h"
#import "AppDelegate.h"
#define APPDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))
#define MainScreenBbounds       [[UIScreen mainScreen] bounds]
#define SCREEN_W                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H                [[UIScreen mainScreen] bounds].size.height
#define NAVBAR_H                [EHSysProperty         getNavBarHight]

#define TABBAR_H                                       52
#define KBGIMAGEVIEWTAG                                31415926

#define KTelphoneMaxLength                             11                     //手机号输入长度限制
#define KPinMaxLength                                  6                      //验证码输入长度限制
#define KPasswordMaxLength                             24                     //密码长度限制。
#define KMaxCreateFamily                               5                      //最大可创建家庭数量

#define EHRoomSummaryCellHight                         217*(SCREEN_W/375.0)
#define EHRoomSummaryCellTopHight                      165*(SCREEN_W/375.0)
#define EHRoomSummaryCellBottomHight                   40*(SCREEN_W/375.0)
#define MarginW(X) [EHSysProperty                      adjustGapW:X]
#define MarginH(X) [EHSysProperty                      adjustGapH:X]

extern float                                           Margin_left;
extern float                                           Margin_top;
extern float                                           Margin_table_top;
extern float                                           Padding_cell;
extern float                                           Height_Cell_Myview;
extern float                                           Height_Cell_CertView;
extern float                                           Height_Cell_AvatarView;
extern float                                           Height_Button;

extern float                                           Margin_Gap_topLabel;
extern float                                           switchLeftMargin1;
extern float                                           switchLeftMargin2;
extern float                                           switchLeftMargin3;
extern float                                           switchChannel_H;
extern float                                           switchLine_Y;
extern float                                           switchText_Y;
extern float                                           switchSignal_X;
extern float                                           switchBattery_X;

extern float                                           Offset_Badge;
extern float                                           tabbar_Offset_Badge;
extern int                                           PageControl_Height;

extern int                                              ipcDirectButtonWidth;
//门锁页面相关
extern float                                            doorLockHintLabelY;
extern float                                            doorLockY;
extern float                                            doorLockWidth;
extern float                                            doorStateLabelY;
extern float                                            doorCtrlkeyWidth;
extern float                                            doorLockWaitingWidth;
extern float                                            doorWaitingY;
extern float                                            doorCtrlWaitingY;
extern float                                            doorCtrlKeyY;
extern float                                            doorCtrlMovingHeight;
extern float                                            doorCtrlMovingWidth;



void                                                   initFitDimension();
