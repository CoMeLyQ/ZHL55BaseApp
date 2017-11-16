

#import <UIKit/UIKit.h>


@interface CustomTabBar : UITabBarController {
	NSMutableArray *buttons;
	int currentSelectedIndex;
	//UIImageView *slideBg;
}
@property (nonatomic, assign) int	currentSelectedIndex;
@property (nonatomic,retain) NSMutableArray *buttons;
@property (nonatomic,retain) NSMutableArray *lbls;

-(NSArray *)cusViewControllers;
    

+ (id)Share;
- (void)selectedTabIndex:(NSString *)indexStr;

-(void)updateCustomTabBarControllers;
//- (void)selectedTab:(UIButton *)button;
@end

