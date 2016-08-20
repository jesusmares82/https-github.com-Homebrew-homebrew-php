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
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.5.38.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.38'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :sha256 => '473c81ebb2e48ca468caee031762266651843d7227c18a824add9b07b9393e38',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.6.24.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.24'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :sha256 => 'bf23617ec3ed0a125ec8bde2b7bca9d3804b2ff4df8de192890c84dc9fac38c6',
                      }
  end

  module Php70Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-7.0.9.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.0.9'
    PHP_BRANCH      = 'PHP-7.0'

    PHP_CHECKSUM    = {
                        :sha256 => '2ee6968b5875f2f38700c58a189aad859a6a0b85fc337aa102ec2dc3652c3b7b',
                      }
  end

  module Php71Defs
    PHP_SRC_TARBALL = 'https://downloads.php.net/~davey/php-7.1.0beta3.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.1.0-beta.3'
    PHP_BRANCH      = 'PHP-7.1.0'

    PHP_CHECKSUM    = {
                        :sha256 => '913ff2dc0e28535b96f58dfcdc631ce5a14db415f314e9436e1751a53a4afb09',
                      }
  end
end
