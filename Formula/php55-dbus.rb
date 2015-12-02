require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dbus < AbstractPhp55Extension
  init
  desc "Extension for interaction with DBUS busses"
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    sha256 "10089ecfa413de28a8f18ef1a5ef9b16a367d9d71358357848db17b4414761b9" => :el_capitan
    sha256 "b8f5ad766bfd8f2f61a22159bee368e5b4b3379a043fce22c7e887f0e3b2d777" => :yosemite
    sha256 "e13a91191193a11838e3fab5e3012b3fcc888770122e9f91f36138a6fac0bed5" => :mavericks
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
