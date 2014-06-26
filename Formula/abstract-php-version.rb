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
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.4.29.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.4.29'
    PHP_BRANCH      = 'PHP-5.4'

    PHP_CHECKSUM    = {
                        :md5    => '64326cef257e5af17c366fefab136e53',
                        :sha1   => '199cfe6ba44732d737e03e5321ea9399823759d7',
                        :sha256 => '62ce3ca063cf04f6065eeac82117e43b44e20487bc0a0a8d05436e17a0b1e2a7',
                      }
  end

  module Php55Defs
    PHP_SRC_TARBALL = 'http://www.php.net/get/php-5.5.13.tar.bz2/from/this/mirror'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.5.13'
    PHP_BRANCH      = 'PHP-5.5'

    PHP_CHECKSUM    = {
                        :md5    => 'e26e90af25ee6505dc18855e0180ffe9',
                        :sha1   => 'b16ff3218d2cc79a5acac577f7560dbb80f205d1',
                        :sha256 => 'e58a4a754eb18d2d8b1a120cad5cce4ed24a7db5d49eca5830a40e4c8ca78b9c',
                      }
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'http://downloads.php.net/tyrael/php-5.6.0RC1.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.0-rc.1'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => 'aeedca033144aa7ab155816e9dceb615',
                        :sha1   => '5025a078c4464fefd199b415d22d9082088770c0',
                        :sha256 => '695f28e5b0751bd583986d79759b3b76871cb9bf6624bd5e8ce6bd1e64e183d7',
                      }
  end
end
