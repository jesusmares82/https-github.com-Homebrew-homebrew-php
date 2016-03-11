require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pickle < AbstractPhpPhar
  init
  desc "Pickle installs PHP extensions easily on all platforms."
  homepage "https://github.com/FriendsOfPHP/pickle"
  url "https://github.com/FriendsOfPHP/pickle/releases/download/v0.4.0/pickle.phar"
  version "0.4.0"
  sha256 "d666ca81fde5ecb3881e603edd8f656fbd967cf98c82c2fd9c16fc64e0d4f9a5"

  test do
    system "pickle", "--version"
  end
end

