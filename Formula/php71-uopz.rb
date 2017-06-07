require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Uopz < AbstractPhp71Extension
  init
  desc "Exposes Zend Engine functionality."
  homepage "http://php.net/manual/en/book.uopz.php"
  version "5.0.1.5"
  url "https://github.com/krakjoe/uopz.git",
  :using => :git,
  :revision => "1e81e56b6c7ca1d7ad58c97832f31a39fb61d4f2"
  sha256 "d4dceb4705f8ea99e836864615bff2ca90da150cc95fb3bc68be8501f932d0bb"
  head "https://github.com/krakjoe/uopz.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9c995c1721f79b7eb72c63405e057cb2c1b0b33b6d37165c51c6215c75835dab" => :sierra
    sha256 "30046f5bc694adf1e863686bbcc3f160fc613ad56d9e67708c12435d1c8f61c8" => :el_capitan
    sha256 "0f4fdf004d78c45e3048949c22eb160586b1ca9b2b7685d334ffdea4ad1d94e8" => :yosemite
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
