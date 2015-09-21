require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Jsmin < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "b3dc3422aff3cfd35ab6533f8ed582a5ef1d91021fdc69bd73759aa0b4b9ba03" => :el_capitan
    sha256 "7a8ef3ccccd68ceef6d359bfcc8b3661fe49e3961720c6feb133d9721db15894" => :yosemite
    sha256 "61fee60419a0fa91931eb23e0d539454ce6aa89dc46626b47d978043a5bc2fa2" => :mavericks
  end

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file if build.with? "config-file"
  end
end
