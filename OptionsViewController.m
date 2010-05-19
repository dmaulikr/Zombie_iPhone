//
//  OptionsViewController.m
//  ZombieGame
//
//  Created by David Guinnip on 5/16/10.

#import "OptionsViewController.h"
#import "ZombieGameAppDelegate.h"

@implementation OptionsViewController



-(IBAction) onFinished:(id) sender{
	[[self parentViewController] dismissModalViewControllerAnimated:NO];
}


-(IBAction) onDeletedButton:(id) sender{
	
	ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate deleteAllScores];
}


-(IBAction) onSwitchFX:(UISwitch *) sender{
	if(sender != NULL)
	{
		ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
		if(sender.on)
			appDelegate.soundFX = YES;
		else {
			appDelegate.soundFX = NO;
			
		}

			
	}
}

-(IBAction) onSlideVolume:(id) sender{
	UISlider *slider = (UISlider *)sender;
	if(slider != NULL)
	{
		ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
		//[slider value]
		[appDelegate BackgroundVolume:[slider value]];
	}

}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
