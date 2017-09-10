require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ref < AbstractPhp72Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.5.0.tar.gz"
  sha256 "0fd928fd8314f836a97e3833d6c5e15658202d05fe3a0725d793f6e06394cd97"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cfd6b74a7530c8ec9ef31e781f2ee5c48870a8c0529f1c5b0d2d11c6a4a626b7" => :sierra
    sha256 "2a960f30cd3ce608d122cd0260ec522c06828dbc45d7a207d609c848bf866f75" => :el_capitan
    sha256 "661f28161adbe8c2c694b6cd8b7ad64093603690483220884370f23369b8ad02" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end
end
