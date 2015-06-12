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
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.4.42.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.42'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '6e0c28e22c0751c57a8c14a6f463c30d',
                        :sha1   => 'fa7d35d9766ebd055ac7ccdda1d86c53425ea0bc',
                        :sha256 => '6285b2e64bfaa69e5d983d7d981b4f254f5259ad3fd591ca832722a4cc1ae0f9',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.5.25.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.25'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'b3c38f0a12e27722585d962d86dfdd16',
                        :sha1   => '89a7c0de86db9e06106f5bc091b13aa0c0e06952',
                        :sha256 => '68df37e725ddd05675c0df906041038127938ecc52113a54d10e1e4029262c63',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://www.php.net/get/php-5.6.9.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.9'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '561f37377833772ace776143c5687884',
                        :sha1   => 'a03f3a168a83a5e6fb983c44933f23fc44323a00',
                        :sha256 => '19d3b87b7b8bba3be24cf6d757d16b723a98881c3af8d15469fd25501e9abcb9',
                      }
  end
end
