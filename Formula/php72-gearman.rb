require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gearman < AbstractPhp72Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz"
  sha256 "f71e8ff218f31e3b9a15534e18846b9f9526319daffcc12e76b545889e44e130"
  head "https://github.com/wcgallego/pecl-gearman.git"

  depends_on "gearman"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"

    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
