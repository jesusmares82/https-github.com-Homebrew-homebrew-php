require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Translit < AbstractPhp71Extension
  init
  desc "transliterates non-latin character sets to latin"
  homepage "https://github.com/derickr/pecl-translit"
  url "https://github.com/derickr/pecl-translit/archive/RELEASE_0_6_2.tar.gz"
  sha256 "863ba3793d09776c309ae1a46af2826f8acf855db10ba8d976716ec6ab2ea3a5"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/translit.so"
    write_config_file if build.with? "config-file"
  end
end
