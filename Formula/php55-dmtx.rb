require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  desc "PHP bindings for the dmtx library"
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  revision 5
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "6efd573757d30b0a78707a40bd59453f02cdd969db1878a2a2db1b9c76f1042e" => :sierra
    sha256 "ffbf1e3a9a8770d975c0198f40278543e62aaf87a340e2441ac9d48a147bb197" => :el_capitan
    sha256 "6cfc2aa08d930bb9957b32448a2e9b54235fbd193cd7e3ca02f74e40446d8d1d" => :yosemite
  end

  depends_on "libdmtx"
  depends_on "php55-imagick"
  depends_on "pkg-config" => :build

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/dmtx.so]
    write_config_file if build.with? "config-file"
  end
end
