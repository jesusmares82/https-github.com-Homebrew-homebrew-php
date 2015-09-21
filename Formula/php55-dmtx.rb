require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dmtx < AbstractPhp55Extension
  init
  homepage "http://www.libdmtx.org"
  url "https://github.com/maZahaca/php-dmtx/archive/0.0.3-dev.tar.gz"
  version "0.0.3"
  sha256 "864a2c9a39812e89d4aa3379cdf543a10a88b227cbe6d57ac94f2fd388b35e26"
  head "https://github.com/maZahaca/php-dmtx.git"

  bottle do
    sha256 "2dadf20327c51952bb3b6176bc38b461c196c0512d5246041e776e4fe04cddf6" => :el_capitan
    sha256 "670860eb52a6f79fabaa69bd16861c561e70c7a368f77374440b30784135ab28" => :yosemite
    sha256 "b564501a68afa16a3acbf05cf48b2cc390437234b37bb1f781b5657985d04e71" => :mavericks
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
