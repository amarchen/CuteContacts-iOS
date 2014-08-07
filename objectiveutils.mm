#include "objectiveutils.h"
#include <UIKit/UIKit.h>

void ObjectiveUtils::setGoodStatusBarStyle()
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; // white text
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; // default black text
}
