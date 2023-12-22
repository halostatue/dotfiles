set -q KERL_BASE_DIR; or set -gx KERL_BASE_DIR $HOME/.kerl
set -gx KERL_DEFAULT_INSTALL_DIR $KERL_BASE_DIR/installs
set -gx KERL_BUILD_BACKEND git
set -gx KERL_BUILD_DOCS yes
