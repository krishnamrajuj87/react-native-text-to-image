#import "TextToImage.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@implementation TextToImage
RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(convert:(NSString *)text fontName:(nonnull NSString *)fontName fontSize:(CGFloat)fontSize color:(NSString *)hexColor callback:(RCTResponseSenderBlock)callback)
{
  [self textToImage:text fontName:fontName fontSize:fontSize color:hexColor callback:callback];
}
- (void)textToImage:(NSString *)text fontName:(NSString *)fontName fontSize:(CGFloat)fontSize color:(NSString *)hexColor callback:(RCTResponseSenderBlock)callback {
 UIFont *font = [UIFont fontWithName:fontName size:fontSize * 2];
 NSDictionary *attributeDic = @{NSFontAttributeName:font};
  CGSize size = [text boundingRectWithSize:CGSizeMake(560, 10000)
                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                  attributes:attributeDic
                    context:nil].size;
  if ([UIScreen.mainScreen respondsToSelector:@selector(scale)]) {
    if (UIScreen.mainScreen.scale == 2.0) {
      UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    } else {
      UIGraphicsBeginImageContext(size);
    }
  } else {
    UIGraphicsBeginImageContext(size);
  }
  CGContextRef context = UIGraphicsGetCurrentContext();
  [[UIColor whiteColor] set];
  CGRect rect = CGRectMake(0, 0, size.width + 1, size.height + 1);
  CGContextFillRect(context, rect);
  NSDictionary *attributes = @ {
    NSForegroundColorAttributeName:[UIColor blackColor],
          NSFontAttributeName:font
  };
  [text drawInRect:rect withAttributes:attributes];
  UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
 NSString *base64String = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
 NSString *response = [NSString stringWithFormat:@"%@:%f", base64String, size.width];
  callback(@[response]);
  // Clean up
  UIGraphicsEndImageContext();
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end