/**
 * Tae Won Ha — @hataewon
 *
 * http://taewon.de
 * http://qvacua.com
 *
 * See LICENSE
 */

#import <TBCacao/TBCacao.h>
#import <MacVimFramework/MacVimFramework.h>
#import "VRDocumentController.h"


@interface VRManualBeanProvider : NSObject <TBManualBeanProvider>
@end

@implementation VRManualBeanProvider

// TODO: why did I use a static method here? Use an instance method (TBD in TBCacao)
+ (NSArray *)beanContainers {
    static NSArray *manualBeans;

    if (manualBeans == nil) {
        VRDocumentController *documentController = [[VRDocumentController alloc] init];

        /**
        * TODO: MMVimController uses [MMVimManager sharedManager].
        * At some point, we should get rid of that and use alloc + init.
        * For time being, let's accept this and use the shared manager here.
        */
        MMVimManager *vimManager = [MMVimManager sharedManager];

        documentController.vimManager = vimManager;
        vimManager.delegate = documentController;
        [vimManager setUp];

        manualBeans = @[
                [TBBeanContainer beanContainerWithBean:documentController],
                [TBBeanContainer beanContainerWithBean:vimManager],
        ];
    }

    return manualBeans;
}

@end
