#include "objectiveutils.h"
#include <UIKit/UIKit.h>

// This method is supposed to paint system status on top of the app's rectangle, but somehow it doesn't
// Oh well, for a prototype just painting a picture instead of a real statusbar is okay
void ObjectiveUtils::setGoodStatusBarStyle()
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; // white text
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; // default black text
}
