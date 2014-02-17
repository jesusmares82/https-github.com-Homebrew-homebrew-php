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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.4.25.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.25'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '5dca494468e77528e145f8d3f07b389e',
                        :sha1   => 'de42bf7c55f6b16e29b01ada24d9d5055e89a2a7',
                        :sha256 => 'b6c18c07c6bf34f75e601b28829d636e44c1c9f4267aac4ed013443c32a2245f',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.5.9.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.9'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'c4a348a07b52f6e177d8fdc75fe507b1',
                        :sha1   => 'd5dac90bc09f197b73b5bfcc3ca7dd6187f32e16',
                        :sha256 => '9d1dea5195e2bcd928416130a6e19173d02bd36fb76c382522bf145c458fbed3',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'http://downloads.php.net/tyrael/php-5.6.0alpha2.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.0-alpha.2'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => '5a28f05cae2b0077f4126bdc19179dd6',
                        :sha1   => 'f5d53a293805c723d0e4aeb8f3db8b08fdac99d5',
                        :sha256 => '7ad8990bbe6ce2cbb384ad22ecc14385098d6e3c9d4ee1ddd386bc6df3dea504',
                      }
  end
end