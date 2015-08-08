require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tidy < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    sha256 "ce9298d9230bb66a7b08cdd1911a51c2c5859c2fe0a81d289cf33b584de10fc3" => :yosemite
    sha256 "f11e43e79ed5d6386fe2745018b989a01414a288e7d19d5911eb5e4f3f724600" => :mavericks
    sha256 "4214943fcd7bb1dbaca465302ec561fadb14bb6e550ee4c545da60652d9a3ba2" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end

