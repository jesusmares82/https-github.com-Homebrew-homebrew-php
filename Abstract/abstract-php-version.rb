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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.3.28.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.3.28'
    PHP_BRANCH      = 'PHP-5.3'

    PHP_CHECKSUM    = {
                        :md5    => '56ff88934e068d142d6c0deefd1f396b',
                        :sha1   => 'f985ca1f6a5f49ebfb25a08f1837a44c563b31f8',
                        :sha256 => '0cac960c651c4fbb3d21cf2f2b279a06e21948fb35a0d1439b97296cac1d8513',
                      }
  end

  module Php54Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.4.30.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.30'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => 'a8a27fdc1d9e1020c9f8922b608326de',
                        :sha1   => '1dbc68dfb696d0c776a1bcf9566a96b6bae5e1c7',
                        :sha256 => '32b83644e42d57388d6e5ec700c3502cde5f5e1207395b1e361e4cb2ce496ce6',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.5.15.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.15'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => '5cb5f2ed9099299f8a4c952d59d93812',
                        :sha1   => '7e487b27342994e405180dd11a01921b7f34161f',
                        :sha256 => '00f24226b12fee27e332383b6304f1b9ed3f4d9173dd728a68c5c3f5a59b8ba7',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'http://downloads.php.net/tyrael/php-5.6.0RC2.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.0-rc.2'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '6f52262bb7a721c0381a2bd6c16bb21e',
                        :sha1   => '3e22cf637fef1f511bca34827f107f7fd9211511',
                        :sha256 => '526f5def1218b58f68a6633cbf6ce6041ab6d244a0f91c007f20a2c0ed515d98',
                      }
  end
end
