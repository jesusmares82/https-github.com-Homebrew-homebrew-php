class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBAL = 'https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz'
    PHPDBG_CHECKSUM   = {
                        :md5    => '84255abff00fb31e338d03564c3cc4e4',
                        :sha1   => 'c57174ab235ec69997e1a37e6d2afe3e4edfb749',
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
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.5.29.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.29'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :sha256 => 'fbcee579ecc77cad6960a541116aee669cf145c2cd9a54bf60503a870843b946',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.6.13.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.13'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :sha256 => '6358837c9cbab41b91ede59dbf0670ae0fb925a1369ecbc1a44a27212420f893',
                      }
  end

  module Php70Defs
    PHP_SRC_TARBALL = 'https://downloads.php.net/~ab/php-7.0.0RC3.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.0.0-rc.3'
    PHP_BRANCH      = 'PHP-7.0.0'

    PHP_CHECKSUM    = {
                        :sha256 => '5f435e2b4e67def405b407b0b2ab3060493bb9a66f83563570a941832493112d',
                      }
  end
end
