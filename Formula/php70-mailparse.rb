require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mailparse < AbstractPhp70Extension
  init
  desc "Extension for parsing email messages."
  homepage "https://pecl.php.net/package/mailparse"
  url "https://pecl.php.net/get/mailparse-3.0.1.tgz"
  sha256 "42ee10de881a3739acf73ddef8800d80c3c57f70072f41bdb22e6e87ebc9cc62"
  head "https://github.com/php/pecl-mail-mailparse.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3d9d6d0c63b1711158648f025b4573abc0509dc4ee0035f0bc22398b15437ed6" => :el_capitan
    sha256 "61b27cce2e51f09833ce0189a8134b4caab6dcb639081fb902976097afeaaa31" => :yosemite
    sha256 "678333828ac18fcbc0037103e5923984fad00e205f3eff0132eb204d347a1fe2" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "mailparse-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mailparse.so"
    write_config_file if build.with? "config-file"
  end
end
