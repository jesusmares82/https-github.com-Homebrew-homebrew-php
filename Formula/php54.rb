require File.expand_path("../../Abstract/abstract-php", __FILE__)

class Php54 < AbstractPhp
  init
  desc "PHP Version 5.4"
  include AbstractPhpVersion::Php54Defs
  include AbstractPhpVersion::PhpdbgDefs

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 4

  head PHP_GITHUB_URL, :branch => PHP_BRANCH

  bottle do
    sha256 "d44e621d0a674a129d2d25d614cde5579c9e7ef1c43e4c27f90627c63aeaaa93" => :el_capitan
    sha256 "526693fc6302315aeb2f983126e6c2a71b3f10ef8dcb8d81c6782b0a2112eb2b" => :yosemite
    sha256 "08f3bbff4806362f92709c2dee8eac0e7a2d3fed5e41191f339d9a683aad5c59" => :mavericks
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
