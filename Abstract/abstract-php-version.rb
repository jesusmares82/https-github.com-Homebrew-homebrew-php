class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBALL = "https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz".freeze
    PHPDBG_CHECKSUM    = {
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
    PHP_SRC_TARBALL = "https://php.net/get/php-5.6.32.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.6.32".freeze
    PHP_BRANCH      = "PHP-5.6".freeze

    PHP_CHECKSUM    = {
      :sha256 => "3ee44e7a5fa42b563652b3ea0d3487bc236fcc9e5ea74b583775cab867abcb51",
    }.freeze
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.25.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.0.25".freeze
    PHP_BRANCH      = "PHP-7.0".freeze

    PHP_CHECKSUM    = {
      :sha256 => "95a24d96d126a196e1550e394182b43a6460cdd2026f1a77bef01e422415cc25",
    }.freeze
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.10.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.10".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "0ee51b9b1ae7eca3e9558f772ce20cbacd1f76420009b3af630c87027f9a41af",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://downloads.php.net/~pollita/php-7.2.0RC5.tar.bz2".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.0RC5".freeze
    PHP_BRANCH      = "PHP-7.2".freeze

    PHP_CHECKSUM    = {
      :sha256 => "366c68f246febf67a4c58bea560a6e20ef3578c4de49648d219684f272abfdf2",
    }.freeze
  end
end
