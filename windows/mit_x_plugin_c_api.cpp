#include "include/mit_x/mit_x_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "mit_x_plugin.h"

void Mit_xPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  mit_x::Mit_xPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
