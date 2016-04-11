require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaz < AbstractPhp54Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "829b0b0e1ff54e92faf67b28646f63c199579fe8021051a925eeb9637aec5b6d" => :el_capitan
    sha256 "f6cfd1fbda40ab321e79021eee0d4238bd1fe02a375879b34ab9e5bd176a1419" => :yosemite
    sha256 "ce7e58bcee7e566c7e7de95c0d574c68b549fbaab476938531c5a6cc398a0739" => :mavericks
  end

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file if build.with? "config-file"
  end
end
