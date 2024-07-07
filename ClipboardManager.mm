#import "ClipboardManager.h"
#import <Cocoa/Cocoa.h>

@implementation ClipboardManager

+ (NSString *)getClipboardContent {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString *string = [pasteboard stringForType:NSPasteboardTypeString];
    return string ? string : @"";
}

+ (void)setClipboardContent:(NSString *)content {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:content forType:NSPasteboardTypeString];
}

@end