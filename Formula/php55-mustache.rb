require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mustache < AbstractPhp55Extension
  desc "Mustache PHP Extension"
  bottle do
    cellar :any
    sha256 "227ba872eec7df813bab7ad85cd4ae8995f778ae6813ee7025f334c02aa1e910" => :el_capitan
    sha256 "f5b94031e95588ad20c54959adb028bccec0960d11b32dc56dfc84229819f494" => :yosemite
    sha256 "6a0449574a8fef81faebb152b9a5f5abc2a5d093e0d1291a5a37a16c23dd9c1b" => :mavericks
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
