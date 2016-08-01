require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ds < AbstractPhp70Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.0.4.tar.gz"
  sha256 "4cdad2bba1cae18f1196346913ac9a54a23f2e5874fd8678200f88730b2788c6"
  head "https://github.com/php-ds/extension.git"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
