require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Hprose < AbstractPhp54Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "48c1c44d03641b19e1f9671a07d7a39f7772b20109f9b6fb88e5e9f90c7e08ea" => :el_capitan
    sha256 "35e5bd2c794d11fd89bb13920c9a3e3e9b5526d7a2eddcc3ca1f1d218aa0c725" => :yosemite
    sha256 "1aebbd52100d96c0cc79006e36df71ad250846f4639441e4210e1141387c1b80" => :mavericks
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
