require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ds < AbstractPhp71Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.1.5.tar.gz"
  sha256 "0da5444d07cd283b369c98e177656a96508291b921c3e844b9be6c8269e08372"
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
