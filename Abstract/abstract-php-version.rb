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
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.3.29.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.3.29'
    PHP_BRANCH      = 'PHP-5.3'

    PHP_CHECKSUM    = {
                        :md5    => '9469e240cbe6ac865aeaec89b253dd30',
                        :sha1   => '6e9e492c6d5853d063ddb9a4dbef60b8e5d87444',
                        :sha256 => 'c4e1cf6972b2a9c7f2777a18497d83bf713cdbecabb65d3ff62ba441aebb0091',
                      }
  end

  module Php54Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.4.40.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.40'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '19dafb2b9fc31517cf5c3309fb8a9923',
                        :sha1   => 'a4ba79caf32fe0d5dd1ab26fa4a0f4e64107d117',
                        :sha256 => '4898ffe8ac3ccb2d8cc94f7d76a9ea0414d954f5d4479895ddfccdc2e158a51a',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.5.24.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.24'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'f9a8f3e4bb88b33b087bd63732b1402a',
                        :sha1   => '9f446753c994fb2ea9d8a827a43b34a3f2119df3',
                        :sha256 => '801b5cf2e0c01b07314d4ac3c8a7c28d524bdd8263ebdd0e33a99008251316a2',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.6.8.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.8'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => 'a5a6df33aade0cb5425e4374e3832f0b',
                        :sha1   => 'e946b6519a22110bce41b9fba2cf9e51d4070986',
                        :sha256 => '0af0045745d61eeb74a3ea744529a2481b27cb689da720e6c0250675043724e4',
                      }
  end
end
