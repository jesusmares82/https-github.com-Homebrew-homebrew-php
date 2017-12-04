require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xdebug < AbstractPhp72Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.6.0alpha1.tgz"
  sha256 "145f3a41e746e59872d73caf368399f68d4ee8379e449ebd1a62bdaf1927841f"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9530856b0df0a3370879a71e63049fa449830a6096ed0c123bea72c647a640d0" => :high_sierra
    sha256 "b980dcf86ae7d2bfc68c9c5be98fe9b991ab952520735a04f56fa6a1d8bb6d5d" => :sierra
    sha256 "2300383bf347e89604dbdd62358f6d65c9d80bb9c98720af74304685b29f84b0" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
