require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Proctitle < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f1592a12b1df4939af75338e51f88e7436f9e3bdfd83ac58382c4ee281ce2cd0" => :el_capitan
    sha256 "9d4087786bbbbff4f5b62792e0a993dc1bf43f98573415962e81197d0b14f9e3" => :yosemite
    sha256 "ba83be6426dab2ec78bb7cf9ea3c3249a98651448f46c0c82a3afc6f11a9b9d2" => :mavericks
  end

  def install
    Dir.chdir "proctitle-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/proctitle.so]
    write_config_file if build.with? "config-file"
  end
end
