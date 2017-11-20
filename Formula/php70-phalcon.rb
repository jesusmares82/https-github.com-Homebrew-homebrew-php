require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.2.4.tar.gz"
  sha256 "0c1cbe56aa0571bd5e3c5808ee9488b223ae0451e8f3d4eb7179a11875635e1b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bb0fc3155c04339a302dfb38d01c854fd5fbf04869bc53a0a53cefa6ce01b0d1" => :high_sierra
    sha256 "ae0d63b4270a77411f693364dc1e243a1792df470dfcf2650e98e238047b3cf9" => :sierra
    sha256 "58b94fea26dd8e54aaa19a50f7c002920d5e9319ee3b8b47665c2986dddc8e6b" => :el_capitan
  end

  depends_on "pcre"

  def install
    Dir.chdir "build/php7/64bits"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
