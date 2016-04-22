require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56V8js < AbstractPhp56Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  revision 2

  bottle do
    cellar :any
    sha256 "fa08487bf6ac45f4bcf3ed06d40f98304aa0d77561125a5faf59f11f2a7a30cb" => :el_capitan
    sha256 "88f2b94c8a591a1e077d8ffad93d1592df251d09ce35624acd02bfaa201909ce" => :yosemite
    sha256 "88121f0bb0bbc8422df55751d018ea7750aa132b761f9b21a0959b1d62c8c25d" => :mavericks
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
