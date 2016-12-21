require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gearman < AbstractPhp71Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.1.tar.gz"
  sha256 "af5172d68fbf111e143d0f8e3a583532b236f1a7137696bc2117955034149adf"
  head "https://github.com/wcgallego/pecl-gearman.git"

  bottle do
    sha256 "bdbce0c4aed0d961f89c11f59624b63de29b98cce60d909bae552343ac1554e2" => :sierra
    sha256 "b90464188ae30f3c57ce5ed5b1f839dde54e5966dd8efc13b725688ce9c3f635" => :el_capitan
    sha256 "20961e693a1a7207d51b449ccedd761e91ee2d4cb58a2a177a6ef6f814042162" => :yosemite
  end

  depends_on "gearman"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"

    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
