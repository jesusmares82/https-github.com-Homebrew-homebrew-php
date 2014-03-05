class AbstractPhpVersion < Formula
  def initialize name='__UNKNOWN__', path=nil
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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.4.26.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.26'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '979e17b5492ce9c65a3c37f22c7c9655',
                        :sha1   => 'd8b309f4891e2a0a8061a518162fa267e0304a01',
                        :sha256 => '5053649317b9331df40bd836c976a32b31dbc5c5d68997d3ae01cb90db22d240',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.5.10.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.10'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'd608230c7890b6a0cc5b92e66e866226',
                        :sha1   => '833cf2a7f5428e95b92c28b6440211f9bd0c7937',
                        :sha256 => 'bb34e61f8e6f56c612867bfe85d144d5045cd5e44497539bc126a4e8c6795419',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'http://downloads.php.net/tyrael/php-5.6.0alpha3.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.0-alpha.3'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '3957c2bdb666ff1bc1d506c0d47fc147',
                        :sha1   => '1b5d70576f1aff5ce8a88b885a5e092a7323fb3c',
                        :sha256 => '7ffa3f8180c99a088b229da444282733732d66fa4bcde7f7e4753e9aa7e10545',
                      }
  end
end