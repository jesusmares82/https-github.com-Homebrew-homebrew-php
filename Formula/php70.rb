require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  revision 8
  bottle do
    sha256 "5696343ee77fae407b0b3254a99ea295475a2ba99ce5adce50d4f7faa3331f30" => :sierra
    sha256 "49b31606a3bc9da9addab0e1af185c057058bee45a3bebf25b2dbf6b214174a3" => :el_capitan
    sha256 "3d6ce06ec1779036a709e0751d15061ada0cd4df6bcb150e76e96e8854c91527" => :yosemite
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
