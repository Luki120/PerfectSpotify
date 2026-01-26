#import <rootless.h>

#define rootlessPathC(cPath) ROOT_PATH(cPath)
#define rootlessPathNS(path) ROOT_PATH_NS(path)

#define kPath rootlessPathNS(@"/var/mobile/Library/Preferences/me.luki.perfectspotifyprefs.plist")
