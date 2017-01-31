require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 3
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "da8eb7f213a81d14c51eda7dd8cfbf4f60ab0b3d5a874a0a171657059b0dd7a4" => :sierra
    sha256 "c85a9b0c5d30e8fb9db1312228bd72a3366541d4bc63c530a3eeb7e726abff68" => :el_capitan
    sha256 "ec7d38404fec249cb96bbb076daa2bd646fe0f3a080180d88d1415b300866f8e" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php55-imagick"
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
