#import "CQConnectionCreationViewController.h"

#import "CQConnectionEditViewController.h"

#import <ChatCore/MVChatConnection.h>

@implementation CQConnectionCreationViewController
- (id) init {
	if (!(self = [super init]))
		return nil;
	self.delegate = self;
	return self;
}

- (void) dealloc {
	[_editViewController release];
	[super dealloc];
}

- (void) viewWillAppear:(BOOL) animated {
	_editViewController = [[CQConnectionEditViewController alloc] init];
	_editViewController.newConnection = YES;

	MVChatConnection *connection = [[MVChatConnection alloc] initWithType:MVChatConnectionIRCType];
	connection.server = @"<<placeholder>>";
	connection.nickname = @"<<default>>";
	connection.realName = @"<<default>>";
	connection.serverPort = 0;

	_editViewController.connection = connection;
	[connection release];

	UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector( cancel:)];
	_editViewController.navigationItem.leftBarButtonItem = cancelItem;
	[cancelItem release];

	UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector( commit:)];
	_editViewController.navigationItem.rightBarButtonItem = saveItem;
	[saveItem release];

	_editViewController.navigationItem.rightBarButtonItem.tag = UIBarButtonSystemItemSave;
	_editViewController.navigationItem.rightBarButtonItem.enabled = NO;

	[self pushViewController:_editViewController animated:NO];
}

- (void) viewDidDisappear:(BOOL) animated {
	[_editViewController release];
	_editViewController = nil;
}

- (void) cancel:(id) sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) commit:(id) sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) navigationController:(UINavigationController *) navigationController willShowViewController:(UIViewController *) viewController animated:(BOOL) animated {
	// Workaround a bug where viewWillAppear: is not called when this navigation controller is a modal view.
	[viewController viewWillAppear:animated];
}

- (void) navigationController:(UINavigationController *) navigationController didShowViewController:(UIViewController *) viewController animated:(BOOL) animated {
	// Workaround a bug where viewDidAppear: is not called when this navigation controller is a modal view.
	[viewController viewDidAppear:animated];
}
@end