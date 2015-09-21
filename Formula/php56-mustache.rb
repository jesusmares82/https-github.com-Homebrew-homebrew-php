require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mustache < AbstractPhp56Extension
  desc "Mustache PHP Extension"
  bottle do
    cellar :any
    sha256 "d152d4750cfdcc53feb42dee2137b0ad74a73381b8035c2ed9007530287a462e" => :el_capitan
    sha256 "0d66cc3b5a7cd496c6ba9444ac9b2f57dfa7139a1b0dc187c17408f66c11d3c9" => :yosemite
    sha256 "4a0901cc612f5156f2ab1674e7bb63f46f845ae90dccb4e43202c7442d6bde75" => :mavericks
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
