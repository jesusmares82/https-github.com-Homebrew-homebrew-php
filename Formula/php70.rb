require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "af61e2c5846e3b1e80e55d219d36462a3c25658054ae150e28b055082c8e2c60" => :yosemite
    sha256 "b06f6b9c8c14b5e37835c75ef7af9f4ccfc2019ebe7c3a0fd10e05871b8b66d6" => :mavericks
    sha256 "8fe540fa4c6b53fdad6bd9695b6e26628c6fb6bbd84f0bcc0d9b2de682f42410" => :mountain_lion
  end

  def install_args
    args = super

    # dtrace is not compatible with phpdbg: https://github.com/krakjoe/phpdbg/issues/38
    if build.without? "phpdbg"
      args << "--enable-dtrace"
      args << "--disable-phpdbg"
    else
      args << "--enable-phpdbg"

      if build.with? "debug"
        args << "--enable-phpdbg-debug"
      end
    end

    args << "--enable-zend-signals"
  end

  def php_version
    "7.0"
  end

  def php_version_path
    "70"
  end
end
