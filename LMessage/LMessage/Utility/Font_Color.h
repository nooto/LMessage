/*### WS@H Project:EHouse ###*/
//
//#import "EHFont_Color.h"

#import "EHSysProperty.h"

/*--------------------------------2.0---------------------------------------*/
/*--------------------------------主要颜色---------------------------------------*/
//主色调
#define Color_Main                          ColorFromHex(0xf8ab32)
#define Color_Main_40                       ColorFromHexRGBA(0xf8ab3266)
#define Color_Main_30                       ColorFromHexRGBA(0xf8ab324d)
#define Color_Main_20                       ColorFromHexRGBA(0xf8ab3233)
#define Color_Main_10                       ColorFromHexRGBA(0xf8ab3219)
//背景色 - 顶部底部栏，一级类别背景色
#define Color_BackGround                    ColorFromHex(0xffffff) //白
//背景辅助色 - 所有页面的背景色
#define Color_BackGroundAuxiliary           ColorFromHex(0xf5f7f9) //灰

/*--------------------------------辅助色---------------------------------------*/
//辅助色 - 红
#define Color_AuxiliaryColor_Red            ColorFromHex(0xf15d3a)
//辅助色 - 绿
#define Color_AuxiliaryColor_Green          ColorFromHex(0x7dc023)
//辅助色 - 我方对话框颜色
#define Color_AuxiliaryColor_DialogBox      ColorFromHex(0x41b5ff)//天蓝
//辅助色 - 线条颜色
#define Color_Line                          ColorFromHex(0xdcdcdc)//灰
/*--------------------------------字体颜色---------------------------------------*/
//字体 - 主要字体颜色，标题、正文等
#define Color_Text_Main                ColorFromHex(0x232323) //黑
//字体 - 辅助性文字等
#define Color_Text_Adjunct             ColorFromHex(0x5d5d5d) //灰
//字体 - 显示性问题等
#define Color_Text_Display             ColorFromHex(0x8d8d8d) //灰
//字体 - 重要文字、部分按钮文字
#define Color_Text_Important           ColorFromHex(0xf5f7f9) //所有页面背景色
//字体 - 主要醒目、重要操作性按钮
#define Color_Text_Alert               ColorFromHex(0xf15d3a) //红
//字体 - 链接性文字
#define Color_Text_Link                ColorFromHex(0x41b5ff) //天蓝
/*--------------------------------字体---------------------------------------*/
//顶部导航字体
#define Font_Navigation                     Font17
//弹框按钮执行文字加粗
#define Font_BombBox_Bold                   Font16
//弹框按钮操作文字不加粗
#define Font_BombBox                        Font16
//主要内容文字
#define Font_Content                        Font14
//主要文字（重要信息）
#define Font_Important                      Font14
//主要文字（重要操作信息）
#define Font_Alert                          Font14
//主要文字的辅助性显示
#define Font_AuxiliaryDisplay               Font14
//辅助性文字、用于主要文字的备注信息等
#define Font_MarkDisplay                    Font12
//辅助性文字小号、用于主要文字的备注信息、链接性文字
#define Font_MarkOrLink                     Font10


/*--------------------------------1.0---------------------------------------*/
#define Color_Navbar            ColorFromHex(0x2A3645)

#define Color_Cell_Separator    ColorFromHex(0xe5e5e5)
#define Color_Title             ColorFromHex(0x656565)

#define Color_text             ColorFromHex(0x646662)

#define Color_Btn_Highlighted   ColorFromHex(0xF0D0C0)
#define Color_Cell_Highlighted  ColorFromHex(0xf0f0f0)

#define Color_orange_F866822    ColorFromHex(0xf86822)//橙色
#define Color_green_88C057      ColorFromHex(0x88c057)//绿色
#define Color_red_eb5050        ColorFromHex(0xeb5050) //红色
#define Color_deepGray_666666   ColorFromHex(0x666666)//深灰
#define Color_midGary_9b9b9b    ColorFromHex(0x9b9b9b)//中灰
#define Color_littleGary_e5e5e5 ColorFromHex(0xe5e5e5)//浅灰（用于文本框内提示文字）

//根据屏幕来确定 宽度和高度上对应的间隔大小。

//2015-05-20 19:23:36
#define Color_greed_normal      ColorFromHex(0x69b825)      //绿色文字 普通效果
#define Color_greed_lighted     ColorFromHexRGBA(0x69b82580)   //绿色文字 触发效果 50%透明度



#define Color_blue_normal       ColorFromHex(0x5eb6d6)    //
#define Color_blue_lighted      ColorFromHex(0x53a1bd)   //

//2015-12-15 17:06:39  新版VI  要求的字体颜色
#define Color_yellow_normal     ColorFromHex(0xF39800)

//#define Color_blue_normal     ColorFromHex(0x41b5ff)

#define Color_orange_normal     ColorFromHex(0xFA7646)   //橘色 退出登录用
#define Color_orange_lighted    ColorFromHexRGBA(0xFA764680)//橘色文字 触发效果。。

#define Color_gray_343F52       ColorFromHex(0x343F52)//灰色  发现设备中的背景色
#define Color_AFAFAF            ColorFromHex(0xAFAFAF)//灰色  发现设备中的背景色

#define Color_white_100         ColorFromHex(0xffffff)      //[EHCommonMethod colorFromColorString:@"#ffffff" alpha:1.0f]       //浅灰（用于文本框内提示文字）
#define Color_white_80          [UIColor colorWithWhite:255 alpha:0.8f]
#define Color_white_70          [UIColor colorWithWhite:255 alpha:0.7f]
#define Color_white_60          [UIColor colorWithWhite:255 alpha:0.6f]
#define Color_white_50          ColorFromHexRGBA(0xffffff7f)//[EHCommonMethod colorFromColorString:@"#ffffff" alpha:0.5f]  //浅灰（用于文本框内提示文字）
#define Color_white_30          [UIColor colorWithWhite:255 alpha:0.3f]
#define Color_white_20          ColorFromHexRGBA(0xffffff33)//[EHCommonMethod colorFromColorString:@"#ffffff" alpha:0.2f]  //浅灰（用于文本框内提示文字）
#define Color_white_10           [UIColor colorWithWhite:255 alpha:0.1f]
#define Color_white_3           [UIColor colorWithWhite:255 alpha:0.03f]
#define Color_white_6           [UIColor colorWithWhite:255 alpha:0.06f]
#define Color_white_5           [UIColor colorWithWhite:255 alpha:0.05f]
#define Color_white_8           [UIColor colorWithWhite:255 alpha:0.08f]

//新的分割线颜色
#define Color_Split_Line        Color_Line
#define Color_Back_Ground       ColorFromHex(0xf5f5f5)

#define Color_black_1           [UIColor colorWithRed:0 green:0 blue:0  alpha:0.01f]
#define Color_black_5           [UIColor colorWithRed:0 green:0 blue:0  alpha:0.05f]
#define Color_black_10          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1f]
#define Color_black_20          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f]
#define Color_black_30          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]
#define Color_black_40          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f]
#define Color_black_50          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]
#define Color_black_60          [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]
#define Color_black_100          [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]

//2015-09-23 11:31:36
#define Color_line              Color_Split_Line//[UIColor colorWithWhite:255 alpha:0.1f]

#define Font30                  [UIFont systemFontOfSize:(30.0f)]
#define Font30Bold              [UIFont boldSystemFontOfSize:(30.0f)]

#define Font28                  [UIFont systemFontOfSize:(28.0f)]
#define Font28Bold              [UIFont boldSystemFontOfSize:(28.0f)]

#define Font20                  [UIFont systemFontOfSize:(20.0f)]
#define Font20Bold              [UIFont boldSystemFontOfSize:(20.0f)]

#define FontTitle               [UIFont systemFontOfSize:(18.0f)] //大号36
#define FontTitleBold           [UIFont boldSystemFontOfSize:(18.0f)] //大号36

#define Font17                 [UIFont systemFontOfSize:(17.0f)] //大号34
#define Font17Bold             [UIFont boldSystemFontOfSize:(17.0f)] //大号34

#define FontSmall               [UIFont systemFontOfSize:(16.0f)]
#define FontSmallBold           [UIFont boldSystemFontOfSize:(16.0f)]

#define Font16                  [UIFont systemFontOfSize:16.0f] //小号32
#define Font16Bold              [UIFont boldSystemFontOfSize:16.0f] //小号32

#define Font15                  [UIFont systemFontOfSize:(15)]
#define Font15Bold              [UIFont boldSystemFontOfSize:(15)]

#define Font14                  [UIFont systemFontOfSize:(14.0f)] //小号28
#define Font14Bold              [UIFont boldSystemFontOfSize:(14.0f)] //小号28

#define Font13                  [UIFont systemFontOfSize:(13.0f)]
#define Font13Bold              [UIFont boldSystemFontOfSize:(13.0f)]

#define Font12                  [UIFont systemFontOfSize:(12.0f)]
#define Font12Bold              [UIFont boldSystemFontOfSize:(12.0f)]

#define Font11                  [UIFont systemFontOfSize:(11.0f)]
#define Font11Bold              [UIFont boldSystemFontOfSize:(11.0f)]

#define Font10                  [UIFont systemFontOfSize:(10.0f)]
#define Font10Bold              [UIFont boldSystemFontOfSize:(10.0f)]





