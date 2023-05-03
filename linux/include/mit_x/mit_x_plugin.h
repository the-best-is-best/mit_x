#ifndef FLUTTER_PLUGIN_MIT_X_PLUGIN_H_
#define FLUTTER_PLUGIN_MIT_X_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _Mit_xPlugin Mit_xPlugin;
typedef struct {
  GObjectClass parent_class;
} Mit_xPluginClass;

FLUTTER_PLUGIN_EXPORT GType mit_x_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void mit_x_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_MIT_X_PLUGIN_H_
