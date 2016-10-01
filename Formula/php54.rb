require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  desc "PHP Version 5.4"
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 6

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "a1ed45d6504b75d1f824e94e325edd7f6621b5f1fe572672a1bf9618911f9c88" => :sierra
    sha256 "40d3ed743be74448dd9f435d73e29c8059ccec267a66335392502e01aed5c487" => :el_capitan
    sha256 "e02bade226764c0d3723258712a4c6ab5747e29813fcbfc9c3a56080201c38d6" => :yosemite
  end

  if build.with? "phpdbg"
    # needed to regenerate the configure script
    depends_on "autoconf" => :build
    depends_on "re2c" => :build
    depends_on "flex" => :build

    resource "phpdbg" do
      url PHPDBG_SRC_TARBAL
      sha256 PHPDBG_CHECKSUM[:sha256]
    end
  end

  def _install
    if build.with? "phpdbg"
      resource("phpdbg").stage buildpath/"sapi/phpdbg"

      # force the configure file to be rebuilt (needed to support phpdbg)
      File.delete("configure")
      system "./buildconf", "--force"
    end

    super
  end

  def php_version
    "5.4"
  end

  def php_version_path
    "54"
  end
end
