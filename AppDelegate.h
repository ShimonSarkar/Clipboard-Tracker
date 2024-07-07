#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property(strong, nonatomic) NSWindow *window;
@property(strong, nonatomic) NSTableView *tableView;
@property(strong, nonatomic) NSMutableArray<NSString *> *clipboardHistory;

@end