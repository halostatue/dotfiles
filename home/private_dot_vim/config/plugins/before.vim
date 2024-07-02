vim9script

# Ensure that specific useful pre-bundled plug-ins are always enabled.

packadd matchit
packadd! editexisting
packadd! editorconfig

if v:versionlong >= 9010369
  packadd comment
endif

runtime ftplugin/man.vim

runtime config/plugins/install_plugin_manager.vim
