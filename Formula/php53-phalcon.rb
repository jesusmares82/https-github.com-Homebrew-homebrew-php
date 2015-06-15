require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "A full-stack PHP framework delivered as a C-extension"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.3.tar.gz"
  sha256 "76e2c28bb86adf8ac165c5d43dfd428aa4b0b93bb92301dd83f96e5263cd5914"
  head "https://github.com/phalcon/cphalcon.git"

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
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

  test do
    shell_output("php -m").include?("phalcon")
  end
end
