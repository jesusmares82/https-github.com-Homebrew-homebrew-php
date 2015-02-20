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
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.4.38.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.38'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '2bf5007ba4bd012f9895c1b441dd4f50',
                        :sha1   => '863fcb872fe20d054d1a3444c27ec7f8be9f4317',
                        :sha256 => 'abf37db0cfadc9bb814f9df35f6aa966ad63f4f4c4475e432ec625568a5d3e88',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.5.22.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.22'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'cd5a6321d71897dec26e29e795926669',
                        :sha1   => '76fcfc157855100e2bb09b22209e78e3088a4b11',
                        :sha256 => 'c218c184bef2905bc79fcdda6040f3d1738261395fb706396935d1c6f6e162bb',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.6.6.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.6'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => 'b198117ee1d44c8143e030cee15f1b52',
                        :sha1   => '6795db456f66193634ff38cf8039636b168eda3c',
                        :sha256 => '09625c9b65e0c8198dc76995a35f0feec0e13ea4489526e64a00954b12adbb4c',
                      }
  end
end
