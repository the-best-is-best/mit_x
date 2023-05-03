#ifndef FLUTTER_PLUGIN_MIT_X_PLUGIN_H_
#define FLUTTER_PLUGIN_MIT_X_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace mit_x {

class Mit_xPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  Mit_xPlugin();

  virtual ~Mit_xPlugin();

  // Disallow copy and assign.
  Mit_xPlugin(const Mit_xPlugin&) = delete;
  Mit_xPlugin& operator=(const Mit_xPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace mit_x

#endif  // FLUTTER_PLUGIN_MIT_X_PLUGIN_H_
