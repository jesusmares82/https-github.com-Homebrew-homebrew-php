class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBAL = "https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz".freeze
    PHPDBG_CHECKSUM   = {
      :sha256 => "feab6e29ef9a490aa53332fe014e8026d89d970acc5105f37330b2f31e711bbd",
    }.freeze
  end

  module Php53Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.3.29.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.3.29".freeze
    PHP_BRANCH      = "PHP-5.3".freeze

    PHP_CHECKSUM    = {
      :sha256 => "c4e1cf6972b2a9c7f2777a18497d83bf713cdbecabb65d3ff62ba441aebb0091",
    }.freeze
  end

  module Php54Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.4.45.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.4.45".freeze
    PHP_BRANCH      = "PHP-5.4".freeze

    PHP_CHECKSUM    = {
      :sha256 => "4e0d28b1554c95cfaea6fa2b64aac85433f158ce72bb571bcd5574f98f4c6582",
    }.freeze
  end

  module Php55Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.5.38.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.5.38".freeze
    PHP_BRANCH      = "PHP-5.5".freeze

    PHP_CHECKSUM    = {
      :sha256 => "473c81ebb2e48ca468caee031762266651843d7227c18a824add9b07b9393e38",
    }.freeze
  end

  module Php56Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.6.30.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.6.30".freeze
    PHP_BRANCH      = "PHP-5.6".freeze

    PHP_CHECKSUM    = {
      :sha256 => "a105c293fa1dbff118b5b0ca74029e6c461f8c78f49b337a2a98be9e32c27906",
    }.freeze
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.20.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.0.20".freeze
    PHP_BRANCH      = "PHP-7.0".freeze

    PHP_CHECKSUM    = {
      :sha256 => "cdfddfe01cc615218e333e34a1c761c9ef8fdf5199b27617264a02705eda7fc3",
    }.freeze
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.6.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.6".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "6e3576ca77672a18461a4b089c5790647f1b2c19f82e4f5e94c962609aabffcf",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://downloads.php.net/~pollita/php-7.2.0alpha2.tar.bz2".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.0alpha2".freeze
    PHP_BRANCH      = "master".freeze

    PHP_CHECKSUM    = {
      :sha256 => "f084bcbf26cdbd5fa56ba3b396f0d4e8d2dcf94e593f0629d080dc11a67e18cc",
    }.freeze
  end
end
