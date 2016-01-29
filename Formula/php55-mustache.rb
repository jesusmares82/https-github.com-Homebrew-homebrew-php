require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mustache < AbstractPhp55Extension
  init
  desc "Mustache PHP Extension"
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.7.0.tar.gz"
  sha256 "d01f9969e890f1aa0033c62d06495fa3273c33b02d24794a3f51831200284674"
  head "https://github.com/jbboehr/php-mustache.git"

  bottle do
    cellar :any
    sha256 "e7af8f8d4f3a3cc0805fbbea6ca3e1f75473f745f956e45bf49b6864ced40bdf" => :el_capitan
    sha256 "5ef69f3e535b14d2b71041cb00d77c9c888fbe94af962190bddf24656001491f" => :yosemite
    sha256 "2b3a0b1effe976159daa2d43c114b873f49299639ffbfba10adf0d5ba00370ed" => :mavericks
  end

  depends_on "libmustache"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/mustache.so"
    write_config_file if build.with? "config-file"
  end
end
