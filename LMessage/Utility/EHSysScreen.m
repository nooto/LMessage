//

#import "EHSysScreen.h"

 float  Margin_left = 30;
 float  Margin_top = 10;
 float  Margin_table_top = 150;
 float  Padding_cell = 10;
 float  Height_Cell_Myview = 50;
 float  Height_Cell_CertView = 54;
 float  Height_Cell_AvatarView = 90;
 float  Height_Button = 40;
 float  Margin_Gap_topLabel =  78;

float  switchLeftMargin1 = 230/3;
float  switchLeftMargin2 = 90/3;
float  switchLeftMargin3 = 48/3;
float  switchChannel_H = 570/3;
float  switchLine_Y = 136/3;
float  switchText_Y = 39/3;
float  switchSignal_X = 130;
float  switchBattery_X = 280;
int PageControl_Height = 4;
int ipcDirectButtonWidth = 242;

float  Offset_Badge = 38;
float  tabbar_Offset_Badge = 10;

float  doorStateLabelY = 170;
float  doorLockY = 354;

float  doorLockWidth = 42;

float  doorCtrlkeyWidth = 61;
float  doorCtrlKeyY = 300;
float  doorCtrlWaitingY = 266;
float  doorLockWaitingWidth = 71;
float  doorCtrlMovingHeight = 7;
float  doorCtrlMovingWidth = 15;
float  doorLockHintLabelY = 440;

void initFitDimension(){
    float h = SCREEN_H;//480,568,667,736
    if (480 == h) {//4s及以前
        Offset_Badge = 10;
        Margin_left = 25;
        
        Margin_top = 5;
        
        Margin_table_top = 120;
        
        Padding_cell = 5;
        switchSignal_X = 100;
        Height_Cell_Myview = 44;
        Height_Cell_CertView = 45;
        Height_Cell_AvatarView=80;
        Height_Button = 30;
        ipcDirectButtonWidth = 160;
        switchLeftMargin1 = 50;
        
        doorCtrlWaitingY = 300;
        doorLockY = 230;
        doorLockWaitingWidth = 60;
        doorStateLabelY = 155;
        doorLockHintLabelY = 380;
    }
    else if (568 == h) {//5,5s,5s
        Offset_Badge = 10;
        switchLeftMargin1 = 65;
        switchLeftMargin2 = 27;
        switchLeftMargin3 = 10;
        //        switchChannel_H = 570/3;
        //        switchLine_Y = 136/3;
        //        switchText_Y = 39/3;

        ipcDirectButtonWidth = 200;
        switchSignal_X = 100;
        switchBattery_X = 235;
        
        doorCtrlWaitingY = 227;
        doorLockY = 300;
        doorLockWaitingWidth = 60;
        doorStateLabelY = 142;
        doorLockHintLabelY = 360;
    }
    else if (667 == h) {//6
//        switchLeftMargin1 = 200;
        switchLeftMargin2 = 90/3;
        switchLeftMargin3 = 10;
//        switchChannel_H = 570/3;
//        switchLine_Y = 136/3;
//        switchText_Y = 39/3;
        
        switchSignal_X = 120;
        switchBattery_X = 270;
    }
    else if (736 == h) {//6p
        ipcDirectButtonWidth = 300;
        PageControl_Height = 6;
        doorCtrlkeyWidth = 74;
        
        doorStateLabelY = 190;
        doorLockY = 400;
        doorCtrlWaitingY = 293.5;
        doorLockWaitingWidth = 79;
        doorLockHintLabelY = 480;
    }
}
