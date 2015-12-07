require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Phalcon < AbstractPhp55Extension
  init
  desc "A full-stack PHP framework"
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.9.tar.gz"
  sha256 "3f06c2c140b502547920f83e4acb29e1da6261d22c6154ac40b3f81f09ee6b74"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dd30c773daf9ff7c2027cd6b462a43e620026213db0fc069eab5d57b408fa16c" => :el_capitan
    sha256 "c903bb08f1bd9c1ef970f321cddf1e1daf105c3e00709cd581598c44e573a318" => :yosemite
    sha256 "59b6462977e55350073b04bbdef37e7d9dac01e69b204936e11257278bedbb49" => :mavericks
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
