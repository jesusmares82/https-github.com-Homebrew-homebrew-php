require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Snappy < AbstractPhp55Extension
  init
  homepage "https://github.com/kjdev/php-ext-snappy"
  url "https://github.com/kjdev/php-ext-snappy/archive/db3abe6ef6b0e74c8deed0f285cdc9d8cff094ef.tar.gz"
  sha256 "4d1acaad08eacaa108618c6c765fe2d8da82c2f09f8996036e8bccb5438ebd61"
  version "0.1.0"

  depends_on "snappy"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/snappy.so"
    write_config_file if build.with? "config-file"
  end
end
