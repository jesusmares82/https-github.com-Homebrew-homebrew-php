class AbstractPhpVersion < Formula
  def initialize(name, *args)
    begin
      raise "One does not simply install an AbstractPhp formula" if name == "abstract-php-version"
      super
    rescue Exception => e
      # Hack so that we pass all brew doctor tests
      reraise = e.backtrace.select { |l| l.match(/(doctor|cleanup|leaves|uses)\.rb/) }
      raise e if reraise.empty?
    end
  end

  # Hack to allow 'brew uses' to work, which requires deps, version, and requirements
  %w(deps requirements version).each do |method|
    define_method(method) do
      if defined?(active_spec) && active_spec.respond_to?(method)
        active_spec.send(method)
      else
        method === 'version' ? 'abstract' : []
      end
    end
  end

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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.5.14.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.14'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'b53e5f47c59ffbe26d20957636695baa',
                        :sha1   => '062d351da165aa0568e4d8cbc53a18d73b99f49a',
                        :sha256 => 'df5a057877f827549e0a60b43fb01e4bd440814bcf04fbd70bacbddf74482610',
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
