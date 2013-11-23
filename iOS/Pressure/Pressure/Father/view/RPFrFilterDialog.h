//
//  RPFrFilterDialog.h
//  Pressure
//
//  Created by eason on 11/14/13.
//  Copyright (c) 2013 EasonCompany. All rights reserved.
//

#import "CustomDialog.h"
@class RPSearchType;
typedef enum _RPFrFilterDialog_Type
{
    RPFrFilterDialog_Type_Find_Father,
    RPFrFilterDialog_Type_To_Be_Father
}RPFrFilterDialog_Type;
@interface RPFrFilterDialog : CustomDialog

- (id)initWithDelegate:(id <CustomDialogDelegate>)delegate type:(RPFrFilterDialog_Type)type;

@property (nonatomic,retain) RPSearchType *searchType;
@end
