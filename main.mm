#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
@end

int main(int argc, const char* argv[]) {
    return NSApplicationMain(argc, argv);
}
