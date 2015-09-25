require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.8.tar.gz"
  sha256 "ff61532ebb5dd99c43ce0ba508f0f37b87607f24fb7f595268dbe6331f3c906b"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "329a526715dbab748a0e32e226b3791a2192ea814a786571b0c4f5b5fda2d439" => :el_capitan
    sha256 "7f7cb573a51f654fb3d23821137edd8b8aab837dfcb95083b0eb12a0b874f745" => :yosemite
    sha256 "4cfbf212a6936a6cde4f32174d2a4854ab7a2cba1e514098df0139e4736be041" => :mavericks
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
