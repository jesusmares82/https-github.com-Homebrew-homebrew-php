require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Uopz < AbstractPhp71Extension
  init
  desc "Exposes Zend Engine functionality."
  homepage "http://php.net/manual/en/book.uopz.php"
  url "https://github.com/krakjoe/uopz/archive/v5.0.2.tar.gz"
  sha256 "919f6d7873db89a2032e0145a8e7a355d111f9ab2651aa3fa78b636277034dab"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf668b1daec4e619b1cd17856b176053ac25d2567a65990cf5ae06eddbb703d8" => :sierra
    sha256 "13de24ff12c8ae3ba29d794e4bac64e8871399b97dd8d951c8ebb2de15d2c250" => :el_capitan
    sha256 "d7b465f5d7d1a1794eab36b3174d15ef98c5ee2e88faad5cba5bd945dc77d90d" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uopz.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    caveats = super

    caveats << "  *\n"
    caveats << "  * Important note:\n"
    caveats << "  * Make sure #{config_scandir_path}/#{config_filename} is loaded\n"
    caveats << "  * after #{config_scandir_path}/ext-opcache.ini. Like renaming\n"
    caveats << "  * ext-opcache.ini to opcache.ini.\n"
  end
end
