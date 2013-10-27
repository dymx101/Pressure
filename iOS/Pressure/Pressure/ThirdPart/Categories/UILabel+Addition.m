//
//  UILabel+Addition.m
//  GameChat
//
//  Created by zys on 13-2-17.
//  Copyright (c) 2013年 Ruoogle. All rights reserved.
//

#import "UILabel+Addition.h"
#import "NSString+TomAddition.h"

@implementation UILabel(Addition)

- (void)alignTop {
  if ([self.text isEmpty]) {
    return;
  }
  
  CGSize fontSize = [self.text sizeWithFont:self.font];
  
  if (fontSize.height == 0) {
    return;
  }
  
  double finalHeight = self.frame.size.height;
  double finalWidth = self.frame.size.width;    //expected width of label
  CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
  int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
  for(int i=0; i<newLinesToPad; i++)
    self.text = [self.text stringByAppendingString:@"\n "];
}
@end
