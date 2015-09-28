require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mustache < AbstractPhp54Extension
  desc "Mustache PHP Extension"
  bottle do
    cellar :any
    sha256 "55cb0b82c301090c81885535dbd9c10739af0ae82a2ae892474b58109bbf8b97" => :el_capitan
    sha256 "c6e9352b59c0008c7538598029c5ca6aee374cb79d447bb55a16ff1084980635" => :yosemite
    sha256 "e1b51ada4a1ec40647456de6d6b3be79b8e64654020ffa30d463b0adedac31c8" => :mavericks
  end

  init
  homepage "https://github.com/jbboehr/php-mustache#mustache"
  url "https://github.com/jbboehr/php-mustache/archive/v0.6.0.tar.gz"
  sha256 "56d0057929fb2f0381efc84c748cc7454f07f4cc55064ffb3e723cc1408d6686"

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
