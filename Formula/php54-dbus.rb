require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dbus < AbstractPhp54Extension
  init
  desc "Extension for interaction with DBUS busses"
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    sha256 "507a57fab7d712b44caf7ab8ee02c67d26b620dec561c8ba862f5197199e48de" => :el_capitan
    sha256 "4b82eb999493c3d452b2c1b7bf3e232f4d60909f20463e2e06e964e03beafacd" => :yosemite
    sha256 "5794acf4a9322d4bf8906bc21313691277ad035830cd9731f9656fb663918ecd" => :mavericks
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
