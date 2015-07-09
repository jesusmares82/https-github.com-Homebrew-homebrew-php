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
                        :md5    => '9469e240cbe6ac865aeaec89b253dd30',
                        :sha1   => '6e9e492c6d5853d063ddb9a4dbef60b8e5d87444',
                        :sha256 => 'c4e1cf6972b2a9c7f2777a18497d83bf713cdbecabb65d3ff62ba441aebb0091',
                      }
  end

  module Php54Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.4.42.tar.bz2/from/this/mirror'
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
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.5.26.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.26'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => '383a4b35327809afd2822e1e5efc8ee1',
                        :sha1   => 'f2f80ef51d38b39c4ef060942e2ddcfffec9927a',
                        :sha256 => '816afffdb03ff4c542bc172a2f77f9c69b817df82d60cce05c1b4f578c2c926e',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'https://php.net/get/php-5.6.10.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.10'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '83b17e0cdc72a3a486f5e6342e76c45e',
                        :sha1   => '309255ff5ac3d789f0277354f0686404af646e09',
                        :sha256 => '0a579c81c724ea41815eee0caa8ea7d8eeb302458519d8cc4fc5b055577c8c45',
                      }
  end

  module Php70Defs
    PHP_SRC_TARBALL = 'https://downloads.php.net/~ab/php-7.0.0beta1.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '7.0.0-beta.1'
    PHP_BRANCH      = 'PHP-7.0.0'

    PHP_CHECKSUM    = {
                        :md5    => 'e0067cc043749fa6687f6247b6dd0951',
                        :sha1   => '59288e7a8962d7a5d0a8e4a359099780093a2b52',
                        :sha256 => 'bb0a8a6cc887b7a071bc6a8b0bc9aaa512f17cae4d43b052056794def9cd961a',
                      }
  end
end
