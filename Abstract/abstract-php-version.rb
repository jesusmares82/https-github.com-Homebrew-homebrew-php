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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.3.29.tar.bz2/from/this/mirror'
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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.4.33.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.33'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => 'c6878bb1cdb46bfc1e1a5cd67a024737',
                        :sha1   => 'd92b0bcd18173bbc9aca99be2f184231888b90ab',
                        :sha256 => '1a75b2d0835e74b8886cd3980d9598a0e06691441bb7f91d19b74c2278e40bb5',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.5.18.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.18'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => '6f0d581ed35a2c65188a9513ccc142a0',
                        :sha1   => 'ab76f52d2fc5c1e8d9426b3f1a99f05d10edfcc0',
                        :sha256 => 'f974279927b72b672dda4ef4b4362b4847fd3d19ce1d4f2e982230a4e93bb842',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.6.1.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.1'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '4d0888413f36416a37865feaaa6704c4',
                        :sha1   => '29be35278beaa0853abee4556768f4ef1f97b873',
                        :sha256 => '82c1ccd17830d697d7a4d75bb60ea12be58fa80b4dba101e97db1a6372ca45f0',
                      }
  end
end
