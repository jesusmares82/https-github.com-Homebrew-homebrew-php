require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  desc "PHP Version 5.4"
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 7

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    rebuild 1
    sha256 "4777cc2d42d74b980d7bd8a5e5553764b9f5155021d767cf6c319debe0086edb" => :sierra
    sha256 "06365756a82965adcea1e23b968186e1f7b1c012e46f08918411ba155d96dc27" => :el_capitan
    sha256 "d845b4c32e343ee5a5f6a224e669f63daa9295ed61984316a699999887277247" => :yosemite
  end

  if build.with? "phpdbg"
    # needed to regenerate the configure script
    depends_on "autoconf" => :build
    depends_on "re2c" => :build
    depends_on "flex" => :build

    resource "phpdbg" do
      url PHPDBG_SRC_TARBALL
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
