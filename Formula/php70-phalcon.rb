require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.0.4.tar.gz"
  sha256 "50834275cd964a5d1fdd7a588183ca4e038a46900045a6cf91f50b56664d15cd"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "10993ccc9162cbb87109947ee58a8376f773556c04b50940fc6f0f93ae6c526a" => :sierra
    sha256 "de38f989f9b4d739f5232b6b6bb3e1c25fad8e21223765c2bdb0805fa0fbc7bf" => :el_capitan
    sha256 "2910a2c9693b2f30bc76ccf9de5768b3347681e34bcdc251b8538ca736437574" => :yosemite
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
