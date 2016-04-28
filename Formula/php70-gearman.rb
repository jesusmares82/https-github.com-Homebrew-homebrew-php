require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gearman < AbstractPhp70Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.1.tar.gz"
  sha256 "af5172d68fbf111e143d0f8e3a583532b236f1a7137696bc2117955034149adf"
  head "https://github.com/wcgallego/pecl-gearman.git"

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
