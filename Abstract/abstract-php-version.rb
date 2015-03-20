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
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.4.39.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.39'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '017f7ba7484e738c88bf19eec4369d78',
                        :sha1   => 'b7ae0472a9a6fdd6b1e502650c971717b77d4f84',
                        :sha256 => '7ceb76538e709c74533210ae41148d5c01c330ac8a73220954bbc4fcae69d77e',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.5.23.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.23'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => '9a8fa2ac24ba40f6a837a7e1b436ce60',
                        :sha1   => 'a206cc931bd3aec946a7e5f82b28552d4a93c3cb',
                        :sha256 => 'a99ab264dcd40181baa9defeaa4b21eb2c20d4e9316b904cc05f628762e6ada7',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.6.7.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.7'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '2e4b0534d4b8aa9aabedeef12e7c0aa8',
                        :sha1   => '36a51c7ad98a6ed210673c2e655ba501f0a2f7ed',
                        :sha256 => '02954fb74c61a7879d48ebdcd4ecb78aa0056f4215ca9b096232de28eb8f17bc',
                      }
  end
end
