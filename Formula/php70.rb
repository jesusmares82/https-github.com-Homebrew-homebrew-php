require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php70 < AbstractPhp
  init
  desc "PHP Version 7.0"
  bottle do
    revision 13
    sha256 "d93ba1c767749c09386a4658919f9fc5a1246279b9e580342aa600cbcde05c25" => :el_capitan
    sha256 "82a678c4b02cfc4924555dac7b9d6462d396d8fc371a148661b5d58b38700403" => :yosemite
    sha256 "df5022b528fb6dc2257d27da4bfa520d8cb0e9ab382c0999525558797c8f9ff1" => :mavericks
  end

  include AbstractPhpVersion::Php70Defs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

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




