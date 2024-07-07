#import "AppDelegate.h"
#import "ClipboardManager.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.clipboardHistory = [NSMutableArray array];
    
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(100, 100, 600, 450)
                                              styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    [self.window makeKeyAndOrderFront:nil];
    [self.window setTitle:@"Clipboard History Tracker"];
    
    // Set window background color
    self.window.backgroundColor = [NSColor colorWithCalibratedRed:0.15 green:0.15 blue:0.15 alpha:1.0];
    
    // Add header label
    NSTextField *headerLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(20, self.window.contentView.bounds.size.height - 40, 560, 30)];
    [headerLabel setStringValue:@"Recent Clipboard Items"];
    [headerLabel setFont:[NSFont boldSystemFontOfSize:18]];
    [headerLabel setBezeled:NO];
    [headerLabel setDrawsBackground:NO];
    [headerLabel setEditable:NO];
    [headerLabel setSelectable:NO];
    [headerLabel setTextColor:[NSColor whiteColor]];
    [self.window.contentView addSubview:headerLabel];
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, self.window.contentView.bounds.size.width, self.window.contentView.bounds.size.height - 50)];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    self.tableView = [[NSTableView alloc] initWithFrame:scrollView.bounds];
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"ClipboardContent"];
    [column setWidth:580];
    [self.tableView addTableColumn:column];
    [self.tableView setHeaderView:nil];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView setGridStyleMask:NSTableViewSolidHorizontalGridLineMask];
    [self.tableView setRowHeight:40]; // Increased row height for padding
    [self.tableView setBackgroundColor:[NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
    [self.tableView setGridColor:[NSColor colorWithCalibratedRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
    
    [scrollView setDocumentView:self.tableView];
    [self.window.contentView addSubview:scrollView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClipboardContent) userInfo:nil repeats:YES];
}

- (void)updateClipboardContent {
    NSString *clipboardContent = [ClipboardManager getClipboardContent];
    if (clipboardContent.length > 0 && (self.clipboardHistory.count == 0 || ![clipboardContent isEqualToString:self.clipboardHistory.firstObject])) {
        [self.clipboardHistory insertObject:clipboardContent atIndex:0];
        if (self.clipboardHistory.count > 30) {
            [self.clipboardHistory removeLastObject];
        }
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.clipboardHistory.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTextField *cellView = [tableView makeViewWithIdentifier:@"ClipboardCell" owner:self];
    if (cellView == nil) {
        cellView = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, tableView.bounds.size.width, 40)];
        cellView.identifier = @"ClipboardCell";
        cellView.editable = NO;
        cellView.selectable = YES;
        cellView.bordered = NO;
        cellView.drawsBackground = YES;
        cellView.textColor = [NSColor whiteColor];
        cellView.font = [NSFont systemFontOfSize:14];
    }
    
    NSString *content = self.clipboardHistory[row];
    NSString *truncatedContent = [content length] > 100 ? [[content substringToIndex:100] stringByAppendingString:@"..."] : content;
    cellView.stringValue = truncatedContent;
    
    // Alternate row colors
    if (row % 2 == 0) {
        cellView.backgroundColor = [NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1.0];
    } else {
        cellView.backgroundColor = [NSColor colorWithCalibratedRed:0.22 green:0.22 blue:0.22 alpha:1.0];
    }
    
    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow >= 0 && selectedRow < self.clipboardHistory.count) {
        NSString *selectedContent = self.clipboardHistory[selectedRow];
        [ClipboardManager setClipboardContent:selectedContent];
        
        // Highlight the selected row
        [self.tableView enumerateAvailableRowViewsUsingBlock:^(NSTableRowView *rowView, NSInteger row) {
            if (row == selectedRow) {
                rowView.backgroundColor = [NSColor colorWithCalibratedRed:0.3 green:0.5 blue:0.7 alpha:1.0];
            } else {
                rowView.backgroundColor = [NSColor clearColor];
            }
        }];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end