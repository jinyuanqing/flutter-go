//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<device_info_plus/FPPDeviceInfoPlusPlugin.h>)
#import <device_info_plus/FPPDeviceInfoPlusPlugin.h>
#else
@import device_info_plus;
#endif

#if __has_include(<file_picker/FilePickerPlugin.h>)
#import <file_picker/FilePickerPlugin.h>
#else
@import file_picker;
#endif

#if __has_include(<flutter_inappwebview/InAppWebViewFlutterPlugin.h>)
#import <flutter_inappwebview/InAppWebViewFlutterPlugin.h>
#else
@import flutter_inappwebview;
#endif

#if __has_include(<flutter_keyboard_visibility/FlutterKeyboardVisibilityPlugin.h>)
#import <flutter_keyboard_visibility/FlutterKeyboardVisibilityPlugin.h>
#else
@import flutter_keyboard_visibility;
#endif

#if __has_include(<image_picker_ios/FLTImagePickerPlugin.h>)
#import <image_picker_ios/FLTImagePickerPlugin.h>
#else
@import image_picker_ios;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#else
@import shared_preferences_foundation;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

#if __has_include(<video_player_avfoundation/FVPVideoPlayerPlugin.h>)
#import <video_player_avfoundation/FVPVideoPlayerPlugin.h>
#else
@import video_player_avfoundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FPPDeviceInfoPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FPPDeviceInfoPlusPlugin"]];
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [InAppWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"InAppWebViewFlutterPlugin"]];
  [FlutterKeyboardVisibilityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterKeyboardVisibilityPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
  [FVPVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FVPVideoPlayerPlugin"]];
}

@end
