#import <Foundation/Foundation.h>

@interface ClipboardManager : NSObject

+ (NSString *)getClipboardContent;
+ (void)setClipboardContent:(NSString *)content;

@end