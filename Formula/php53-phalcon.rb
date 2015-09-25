require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.8.tar.gz"
  sha256 "ff61532ebb5dd99c43ce0ba508f0f37b87607f24fb7f595268dbe6331f3c906b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7e9ec71a71023f7eea1c961799a52e768396eddbb4674ad6f9fc7f2d36b83eb4" => :el_capitan
    sha256 "92bdfd8dde34f73df51c77821a2ac8c5bee41732530796ef074dc1106bb95b86" => :yosemite
    sha256 "c89b7a4a2dad3f0aa906af61dee7852473910ba5723ca58c5b7973b9c7ed3e6a" => :mavericks
  end

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
end
