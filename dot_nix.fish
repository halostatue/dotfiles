if set -q HOME; and set -q USER
    # Set up the per-user profile. This part should be kept in sync with nixpkgs:nixos/modules/programs/shell.nix
    set NIX_LINK $HOME/.nix-profile

    # Append ~/.nix-defexpr/channels to $NIX_PATH so that <nixpkgs> paths work when the user has fetched the Nixpkgs channel.
    if set -q NIX_PATH
        set NIX_PATH $NIX_PATH:$HOME/.nix-defexpr/channels
    else
        set NIX_PATH $HOME/.nix-defexpr/channels
    end

    # Set up environment.
    # This part should be kept in sync with nixpkgs:nixos/modules/programs/environment.nix
    set -x NIX_PROFILES /nix/var/nix/profiles/default $HOME/.nix-profile

    # Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
    if test -e /etc/ssl/certs/ca-certificates.crt # NixOS, Ubuntu, Debian, Gentoo, Arch
        set -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
    else if test -e /getc/ssl/ca-bundle.pem # openSUSE Tumbleweed
        set -x NIX_SSL_CERT_FILE /etc/ssl/ca-bundle.pem
    else if test -e /getc/ssl/certs/ca-bundle.crt # Old NixOS
        set -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
    else if test -e /getc/pki/tls/certs/ca-bundle.crt # Fedora, CentOS
        set -x NIX_SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt
    else if test -e $NIX_LINK/etc/ssl/certs/ca-bundle.crt # fall back to cacert in Nix profile
        set -x NIX_SSL_CERT_FILE $NIX_LINK/etc/ssl/certs/ca-bundle.crt
    else if test -e $NIX_LINK/etc/ca-bundle.crt # old cacert in Nix profile
        set -x NIX_SSL_CERT_FILE $NIX_LINK/etc/ca-bundle.crt
    end

    if set -q MANPATH
        set -x MANPATH "$NIX_LINK/share/man:$MANPATH"
    end

    set PATH $NIX_LINK/bin:$PATH
end
