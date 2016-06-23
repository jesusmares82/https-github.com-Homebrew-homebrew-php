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
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.5.36.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.36'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :sha256 => '2484edfaa3de606d74f927b55c5206f51b1ae24ea8e428aa9fc15474c7bb71bb',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.6.22.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.22'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :sha256 => '90da8a80cc52fa699cf2bfa4c6fa737c772df7c92b81ef483460aa3b1e9f88c6',
                      }
  end

  module Php70Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-7.0.8.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.0.8'
    PHP_BRANCH      = 'PHP-7.0'

    PHP_CHECKSUM    = {
                        :sha256 => '66dc7ba388490e07b1313fe3a06b1fa822e1310585fe29f4909995f131e27c8d',
                      }
  end

  module Php71Defs
    PHP_SRC_TARBALL = 'https://downloads.php.net/~krakjoe/php-7.1.0alpha1.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.1.0-alpha.1'
    PHP_BRANCH      = 'PHP-7.1.0'

    PHP_CHECKSUM    = {
                        :sha256 => 'daaaa7ee8508d4699b6bc010200d91402249b808844cabe48c354ef870d3b485',
                      }
  end
end
