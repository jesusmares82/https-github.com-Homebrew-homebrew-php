require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56V8js < AbstractPhp56Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  bottle do
    cellar :any
    sha256 "c08585fc7f77902bf2a09e725b04345df2add54429e03205f65e3608a0a40236" => :el_capitan
    sha256 "bf880098d9e98f76e2ae90394a19dbc42965b986aa974684d4214008c1688026" => :yosemite
    sha256 "b79247f9e71637b33d4066c24c4cbeac3e4c0c49a9a75a951c301e2ad174c699" => :mavericks
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
