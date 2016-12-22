require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.2.tar.gz"
  sha256 "f0b09f96954506d070f8ce5fcb939da79392641230b31f8ff81c8ae9a520d200"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ec660e4585dc0ef7ab30a18b93439fe238714d1e3a435ca8d78cf575b4a2965e" => :sierra
    sha256 "27f8e72a440f058b91e48b8b8af18fdc4c96b7feba02fa19df97ae820b2dbf3f" => :el_capitan
    sha256 "467f8cee0bebc4952d4a7f1b2c4830fb93696e72f798b28f5f8fd7ebc92ce310" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php7/64bits"
    else
      Dir.chdir "build/php7/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
