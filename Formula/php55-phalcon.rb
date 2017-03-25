require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.0.tar.gz"
  sha256 "3b54e6ab1e91aecd606c93c2f762549cd23bad2eef35a3100243ecf6ba85a5c5"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5c174c1ee328832a634fa21e8d34a9049de18e96270f2eb26339c276a53a3878" => :sierra
    sha256 "e0833fbb016116e3e5f27dccba39ec31d68c2f034129b5238d0002a167295f8d" => :el_capitan
    sha256 "187ffa922da2f160fd4d8d54739acc6548c3459c67c705a4caa7a76bdfd54796" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php5/64bits"
    else
      Dir.chdir "build/php5/32bits"
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
