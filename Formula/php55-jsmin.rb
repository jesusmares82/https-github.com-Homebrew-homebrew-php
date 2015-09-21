require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Jsmin < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    sha1 "d2c959b9c9fe65cdcc01cf5d060fab52a1f99a32" => :yosemite
    sha1 "d0afb389706e8feab282d50cdb8b248e10e385ff" => :mavericks
    sha1 "0d75ff0fd9e378b1e74909db53752fcffedbe7df" => :mountain_lion
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
