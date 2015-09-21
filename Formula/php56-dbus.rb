require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dbus < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    sha256 "7e479464a5e0b05fcc835274149a49d13f055558a604e7bdb29ece3687190dc0" => :el_capitan
    sha256 "6829a89d6317dae05808dbf07c57f40a527e5bf4011b2a298fcb942094d0a829" => :yosemite
    sha256 "4ce84f4d7ba78a8e66eec07f3ec5626d8eb2e0fd221d692f621adcd4a175a342" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "d-bus" => :build

  def install
    Dir.chdir "dbus-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/dbus.so"
    write_config_file if build.with? "config-file"
  end
end
