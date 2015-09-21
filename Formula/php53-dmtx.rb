require "formula"
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dmtx < AbstractPhp53Extension
  init
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "a73ad76996a68239552cd6dd72addfe4559e4c8289c7ce5a670aae5ebf592619" => :el_capitan
    sha256 "71ffddf16e59d968d4e934f1c1cdb35f230d515803de92680c99970466a6c56c" => :yosemite
    sha256 "9128b85fed212828fc6d7ec915333daad4567ecd0521e8feda0a8c36d819bdd2" => :mavericks
  end

  depends_on "libdmtx"
  depends_on "php53-imagick"
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
