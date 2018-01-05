require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php71 < AbstractPhp
  init
  desc "PHP Version 7.1"
  revision 24
  bottle do
    sha256 "778ee9ddb791231fa1329b02ede2bf7a0c1b20a96f7ef4d9616b173842abfef9" => :high_sierra
    sha256 "ef1883af76f67b6ffe755701ca29c5f850dd7e750e9bdc5610f0beefc239c23a" => :sierra
    sha256 "7978c01e8abcb1fd9d983c62560688b24701fff4d8388f5245670f051bcae7d2" => :el_capitan
  end

  include AbstractPhpVersion::Php71Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.1"
  end

  def php_version_path
    "71"
  end
end
