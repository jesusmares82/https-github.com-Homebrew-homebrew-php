require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dmtx < AbstractPhp56Extension
  init
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "0d994d87df802298fd8e4490e179ec508ed6e5d0a9fd2c0781e870944d8a3d8b" => :el_capitan
    sha256 "90b075453e9335bd7549c756725f1278b0f153e3b1bc95d23dbea1a7064ed31f" => :yosemite
    sha256 "d66b730f1a3cd0bad5302dcefbfc8c028609a5eeb1a1a709f3dbeb7a4b8777bf" => :mavericks
  end

  depends_on "libdmtx"
  depends_on "php56-imagick"
  depends_on "pkg-config" => :build

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
