//
//  OptionsViewController.m
//  ZombieGame
//
//  Created by David Guinnip on 5/16/10.

#import "OptionsViewController.h"
#import "ZombieGameAppDelegate.h"
#import "ZombieAudio.h"
#import "GameLogic.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation OptionsViewController
@synthesize gameTimer, randomTwitch, twitchRate, isHints, isFX, volumeSlider;



-(void) playSound2:(int) pieceID:(int) expression {
	ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(!appDelegate.soundFX)
		return;
	
	
	NSString *filename = [[ZombieAudio getZombieAudioFile:pieceID:expression] retain];
	//Get the filename of the sound file:
	NSString *path;
	
	
	path = [NSString stringWithFormat:@"%@%@",
			[[NSBundle mainBundle] resourcePath],
			filename];
	
	
	
	
	NSLog(@"%",path);
	
	//declare a system sound id
	SystemSoundID soundID;
	
	//Get a URL for the sound file
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
	
	//Use audio sevices to create the sound
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	
	//Use audio services to play the sound
	AudioServicesPlaySystemSound(soundID);
	
	
}


-(IBAction) onFinished:(id) sender{
	[gameTimer invalidate];
	[gameTimer release];

	[[self parentViewController] dismissModalViewControllerAnimated:NO];
}


-(IBAction) onDeletedButton:(id) sender{
	
	ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate deleteAllScores];
}

-(IBAction) onSwitchFX:(UIButton *) sender
{
	ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
	isFX = !isFX;
	UIImage *img;
	if(isFX){
		[appDelegate SoundFX:YES];
		img  = [UIImage imageNamed:@"b_FX_on.png"];
		 [sender setImage:img forState:UIControlStateNormal];
	}
	else {
		[appDelegate SoundFX:NO];
		img  = [UIImage imageNamed:@"b_FX_off.png"];
		[sender setImage:img forState:UIControlStateNormal];
		
	}

	
}
-(IBAction) onSwitchHints:(UIButton *) sender
{
	ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
	isHints = !isHints;
	UIImage *img;
	if(isHints){
		img  = [UIImage imageNamed:@"b_Hints_on.png"];
		[sender setImage:img forState:UIControlStateNormal];
		[appDelegate ShowHint:YES];
		
	}
	else {
		img  = [UIImage imageNamed:@"b_Hints_off.png"];
		[sender setImage:img forState:UIControlStateNormal];
		[appDelegate ShowHint:NO];
		
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
-(void) gameloop {
	randomTwitch  = randomTwitch ++;
	randomTwitch  = randomTwitch % twitchRate;
	NSLog(@"%d", randomTwitch);
	if(randomTwitch == 0)
	{

		[self playSound2:[GameLogic randomNumber:1,3]:[GameLogic randomNumber:1,2]];
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIImage *img;
	img = [UIImage imageNamed:@"slider_eyeball.png"];
	[volumeSlider setThumbImage:img forState:UIControlStateNormal];
}

-(void) viewWillAppear:(BOOL)animated{
	randomTwitch = 0;
	twitchRate = 15;
	isHints = isFX = YES;
	ZombieGameAppDelegate *appDelegate = (ZombieGameAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate ShowHint:YES];
	gameTimer = [[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(gameloop) userInfo:nil repeats:YES] retain];
}


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
	[gameTimer dealloc];
    [super dealloc];
}


@end
