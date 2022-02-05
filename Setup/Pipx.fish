# brew install pipx

pipx install Pygments
pipx install Sphinx &&
   pipx inject Sphinx --include-apps sphinx-autobuild sphinxcontrib-applehelp \
      sphinxcontrib-devhelp sphinxcontrib-htmlhelp sphinxcontrib-jsmath \
      sphinxcontrib-qthelp sphinxcontrib-serializinghtml
pipx install awscli
pipx install cookiecutter
pipx install csvkit
pipx install doc8
pipx install httpie &&
   pipx inject httpie httpie-http2 httpie-oauth
pipx install isort
pipx install jc
pipx install litecli
pipx install pglast
pipx install pgxnclient
pipx install poetry
pipx install pylint
pipx install remarshal
pipx install rsa
pipx install vim-vint
pipx install ydiff
pipx install azure-cli
pipx install csvs-to-sqlite
pipx install datasette
pipx install git-filter-repo
pipx install graphtage
pipx install j2cli
pipx install kamidana
pipx install poetrify
pipx install saws
pipx install target-csv
pipx install visidata
pipx install xlsx2csv
