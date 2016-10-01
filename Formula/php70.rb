require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    sha256 "ec95a616d3e7f84910c808a2c427dcadcd06e7c3c4076c029542d1f3f84cf71f" => :sierra
    sha256 "1b1c971a7ec46bafbba4cbeae9276c52aee8915133b42ccc1f55f32daffcac40" => :el_capitan
    sha256 "ef3debfbf219464ba847bc7f30691a57330ae87606ccba53e47f04fef096a332" => :yosemite
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 5

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
