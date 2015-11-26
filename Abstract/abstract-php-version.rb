class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBAL = 'https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz'
    PHPDBG_CHECKSUM   = {
                        :sha256 => 'feab6e29ef9a490aa53332fe014e8026d89d970acc5105f37330b2f31e711bbd',
                      }
  end

  module Php53Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.3.29.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.3.29'
    PHP_BRANCH      = 'PHP-5.3'

    PHP_CHECKSUM    = {
                        :sha256 => 'c4e1cf6972b2a9c7f2777a18497d83bf713cdbecabb65d3ff62ba441aebb0091',
                      }
  end

  module Php54Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.4.45.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.45'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :sha256 => '4e0d28b1554c95cfaea6fa2b64aac85433f158ce72bb571bcd5574f98f4c6582',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.5.30.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.30'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :sha256 => 'e7332a713cecdd1cb44a1b1336739885c9789f633f0f51236b25e48ab03c3b29',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.6.15.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.15'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :sha256 => '11a0645c4d4b749e256da1e0d6df89dd886b5b06b83c914d942653661dbd1c38',
                      }
  end

  module Php70Defs
    PHP_SRC_TARBALL = 'https://downloads.php.net/~ab/php-7.0.0RC8.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.0.0-rc.8'
    PHP_BRANCH      = 'PHP-7.0.0'

    PHP_CHECKSUM    = {
                        :sha256 => '8c46621e80b610749d2d31439e9b6db7b881c0249d1df1f4c3e05fdd46a2d108',
                      }
  end
end
